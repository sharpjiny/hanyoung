<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="pagination" id="pagingIns">
<ul>
	<c:if test="${pageParamIns.pageNum > 5}">
		<li><a href="#&pageNumIns=1" pageNumIns="1" title="페이지 맨 앞으로 이동" class="pagingLink"> ‹‹ <span></span></a></li>
		<li><a href="#&pageNumIns=${pageParamIns.pageNum-1}" pageNumIns="${pageParamIns.pageNum-1}" title="페이지 앞으로 이동" class="pagingLink"> ‹ <span></span></a></li>
	</c:if>
	<c:choose>
		<c:when test="${empty pageParamIns.pageNum || pageParamIns.pageNum == 0}">
			<li class="active"><a title="현재 1 페이지" href="javascript:void(0)">1</a></li>
		</c:when>
		<c:otherwise>
			<c:forEach begin="${pageParamIns.pageStart}" end="${pageParamIns.pageEnd}" var="item">
				<c:if test="${item <= pageParamIns.pageTotal}">
					<c:choose>
						<c:when test="${pageParamIns.pageNum==item}">
							<li class="active"><a title="현재 ${item} 페이지" href="javascript:void(0)">${item}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#&pageNumIns=${item}" flag="Ins" pageNumIns="${item}" title="${item} 페이지로 이동" class="pagingLink">${item}</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<c:if test="${pageParamIns.pageTotal > pageParamIns.pageNum && pageParamIns.pageTotal < pageParamIns.pageTotal+5 && pageParamIns.pageTotal > 10}">
		<li><a href="#&pageNumIns=${pageParamIns.pageNum+1}" pageNumIns="${pageParamIns.pageNum+1}" title="페이지 뒤로 이동" class="pagingLink"><span></span> › </a></li>
		<li><a href="#&pageNumIns=${pageParamIns.pageTotal}" pageNumIns="${pageParamIns.pageTotal}" title="페이지 맨 뒤로 이동" class="pagingLink"><span></span> ›› </a></li>
	</c:if>
</ul>
</div>
<script type="text/javascript">
$(function(){
	$(".pagingLink", "#pagingIns").click(paging.moveLink);
});
</script>
