<%@ page contentType="text/html;charset=UTF-8"%>
<div class="modal fade" id="approveRemark" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">备注</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <textarea rows="5" class="form-control" id="content" name="content"></textarea>
    
          </div>
        </form>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" id="approvepass">审核通过</button>
      	<button type="button" class="btn red btn-primary" id="approvenopass">退回</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>
