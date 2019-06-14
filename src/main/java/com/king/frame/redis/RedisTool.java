package com.king.frame.redis;

import java.util.Collections;

import javax.annotation.PostConstruct;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisTool {

	private Log logger = LogFactory.getLog(RedisTool.class);
	
	private static final String LOCK_SUCCESS = "OK";
	private static final String SET_IF_NOT_EXIST = "NX";
	private static final String SET_WITH_EXPIRE_TIME = "PX";
	private static final Long RELEASE_SUCCESS = 1L;

	@Value("${redis.host}")
	private String redisHost = "";
	@Value("${redis.pass}")
	private String redisPassword="";
	@Value("${redis.port}")
	private int redisPort;
	@Value("${redis.maxIdel}")
	private int redisMaxIdel;
	
	private int timeout =30 * 1000;
	
	private JedisPool pool = null;
	
	
	@PostConstruct
	public void init() {

		if (StringUtils.isEmpty(redisHost)) {
			logger.info("redisHost没配置(spring.redis.host),不初始化redis客户端");
			return;
		}
		try {
			JedisPoolConfig config = new JedisPoolConfig();
			// 控制一个pool可分配多少个jedis实例，通过pool.getResource()来获取；
			// 控制一个pool最多有多少个状态为idle(空闲的)的jedis实例。
			config.setMaxIdle(redisMaxIdel);
			// 表示当borrow(引入)一个jedis实例时，最大的等待时间，如果超过等待时间，则直接抛出JedisConnectionException；
			config.setMaxWaitMillis(1000 * 30);
			// 在borrow一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；
			config.setTestOnBorrow(true);
			if (StringUtils.isEmpty(redisPassword)) {
				pool = new JedisPool(config, redisHost, redisPort, timeout);
			} else {
				pool = new JedisPool(config, redisHost, redisPort, timeout, redisPassword);
			}
			logger.info("pool:" + pool);
		} catch (Exception e) {
			throw new RuntimeException("不能初始化Redis客户端", e);
		}
	}
	
	public Jedis getJedis() {
		return pool.getResource();
	}
	
	public void close(Jedis jedis) {
		if (jedis != null) {
			jedis.close();
		}
	}
	
	/**
	 * 尝试获取分布式锁
	 * @param jedis  Redis客户端
	 * @param lockKey  锁
	 * @param requestId  请求标识
	 * @param millisecond 超期时间
	 * @return 是否获取成功
	 */
	public boolean tryGetDistributedLock(String lockKey, String requestId, int expireMillisecond) {
		Jedis jedis = null;
		try {
			jedis = pool.getResource();
			String result = jedis.set(lockKey, requestId, SET_IF_NOT_EXIST, SET_WITH_EXPIRE_TIME, expireMillisecond);
			if (LOCK_SUCCESS.equals(result)) {
				return true;
			}
			return false;
		} catch (Exception e) {
			throw new RuntimeException("Redis出现错误！", e);
		} finally {
			close(jedis);
		}
	}

	/**
	 * 释放分布式锁
	 * @param jedis  Redis客户端
	 * @param lockKey 锁
	 * @param requestId 请求标识
	 * @return 是否释放成功
	 */
	public boolean releaseDistributedLock(String lockKey, String requestId) {
		Jedis jedis = null;
		try {
			jedis = pool.getResource();
			String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
			Object result = jedis.eval(script, Collections.singletonList(lockKey), Collections.singletonList(requestId));
			if (RELEASE_SUCCESS.equals(result)) {
				return true;
			}
			return false;
		} catch (Exception e) {
			throw new RuntimeException("Redis出现错误！", e);
		} finally {
			close(jedis);
		}
	}
}