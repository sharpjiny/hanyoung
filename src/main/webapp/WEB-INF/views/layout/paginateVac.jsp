<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="pagination" id="pagingVac">
<ul>
	<c:if test="${pageParamVac.pageNum > 5}">
		<li><a href="#&pageNumVac=1" pageNumVac="1" title="페이지 맨 앞으로 이동" class="pagingLink"> ‹‹ <span></span></a></li>
		<li><a href="#&pageNumVac=${pageParamVac.pageNum-1}" pageNumVac="${pageParamVac.pageNum-1}" title="페이지 앞으로 이동" class="pagingLink"> ‹ <span></span></a></li>
	</c:if>
	<c:choose>
		<c:when test="${empty pageParamVac.pageNum || pageParamVac.pageNum == 0}">
			<li class="active"><a title="현재 1 페이지" href="javascript:void(0)">1</a></li>
		</c:when>
		<c:otherwise>
			<c:forEach begin="${pageParamVac.pageStart}" end="${pageParamVac.pageEnd}" var="item">
				<c:if test="${item <= pageParamVac.pageTotal}">
					<c:choose>
						<c:when test="${pageParamVac.pageNum==item}">
							<li class="active"><a title="현재 ${item} 페이지" href="javascript:void(0)">${item}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#&pageNumVac=${item}" flag="Vac" pageNumVac="${item}" title="${item} 페이지로 이동" class="pagingLink">${item}</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<c:if test="${pageParamVac.pageTotal > pageParamVac.pageNum && pageParamVac.pageTotal < pageParamVac.pageTotal+5 && pageParamVac.pageTotal > 10}">
		<li><a href="#&pageNumVac=${pageParamVac.pageNum+1}" pageNumVac="${pageParamVac.pageNum+1}" title="페이지 뒤로 이동" class="pagingLink"><span></span> › </a></li>
		<li><a href="#&pageNumVac=${pageParamVac.pageTotal}" pageNumVac="${pageParamVac.pageTotal}" title="페이지 맨 뒤로 이동" class="pagingLink"><span></span> ›› </a></li>
	</c:if>
</ul>
</div>
<script type="text/javascript">
$(function(){
	$(".pagingLink", "#pagingVac").click(paging.moveLink);
});
</script>
