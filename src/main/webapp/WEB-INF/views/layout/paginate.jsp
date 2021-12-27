<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="pagination" id="paging">
<ul>
	<c:if test="${pageParam.pageNum > 5}">
		<li><a href="#&pageNum=1" pageNum="1" title="페이지 맨 앞으로 이동" class="pagingLink"> ‹‹ <span></span></a></li>
		<li><a href="#&pageNum=${pageParam.pageNum-1}" pageNum="${pageParam.pageNum-1}" title="페이지 앞으로 이동" class="pagingLink"> ‹ <span></span></a></li>
	</c:if>
	<c:choose>
		<c:when test="${empty pageParam.pageNum || pageParam.pageNum == 0}">
			<li class="active"><a title="현재 1 페이지" href="javascript:void(0)">1</a></li>
		</c:when>
		<c:otherwise>
			<c:forEach begin="${pageParam.pageStart}" end="${pageParam.pageEnd}" var="item">
				<c:if test="${item <= pageParam.pageTotal}">
					<c:choose>
						<c:when test="${pageParam.pageNum==item}">
							<li class="active"><a title="현재 ${item} 페이지" href="javascript:void(0)">${item}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#&pageNum=${item}" pageNum="${item}" title="${item} 페이지로 이동" class="pagingLink">${item}</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<c:if test="${pageParam.pageTotal > pageParam.pageNum && pageParam.pageTotal < pageParam.pageTotal+5 && pageParam.pageTotal > 10}">
		<li><a href="#&pageNum=${pageParam.pageNum+1}" pageNum="${pageParam.pageNum+1}" title="페이지 뒤로 이동" class="pagingLink"><span></span> › </a></li>
		<li><a href="#&pageNum=${pageParam.pageTotal}" pageNum="${pageParam.pageTotal}" title="페이지 맨 뒤로 이동" class="pagingLink"><span></span> ›› </a></li>
	</c:if>
</ul>
</div>
<script type="text/javascript">
$(function(){
	$(".pagingLink", "#paging").click(paging.moveLink);
});
</script>
