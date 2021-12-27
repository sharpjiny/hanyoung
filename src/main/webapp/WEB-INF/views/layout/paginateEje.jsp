<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="pagination" id="pagingEje">
<ul>
	<c:if test="${pageParamEje.pageNum > 5}">
		<li><a href="#&pageNumEje=1" pageNumEje="1" title="페이지 맨 앞으로 이동" class="pagingLink"> ‹‹ <span></span></a></li>
		<li><a href="#&pageNumEje=${pageParamEje.pageNum-1}" pageNumEje="${pageParamEje.pageNum-1}" title="페이지 앞으로 이동" class="pagingLink"> ‹ <span></span></a></li>
	</c:if>
	<c:choose>
		<c:when test="${empty pageParamEje.pageNum || pageParamEje.pageNum == 0}">
			<li class="active"><a title="현재 1 페이지" href="javascript:void(0)">1</a></li>
		</c:when>
		<c:otherwise>
			<c:forEach begin="${pageParamEje.pageStart}" end="${pageParamEje.pageEnd}" var="item">
				<c:if test="${item <= pageParamEje.pageTotal}">
					<c:choose>
						<c:when test="${pageParamEje.pageNum==item}">
							<li class="active"><a title="현재 ${item} 페이지" href="javascript:void(0)">${item}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#&pageNumEje=${item}" flag="Eje" pageNumEje="${item}" title="${item} 페이지로 이동" class="pagingLink">${item}</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<c:if test="${pageParamEje.pageTotal > pageParamEje.pageNum && pageParamEje.pageTotal < pageParamEje.pageTotal+5 && pageParamEje.pageTotal > 10}">
		<li><a href="#&pageNumEje=${pageParamEje.pageNum+1}" pageNumEje="${pageParamEje.pageNum+1}" title="페이지 뒤로 이동" class="pagingLink"><span></span> › </a></li>
		<li><a href="#&pageNumEje=${pageParamEje.pageTotal}" pageNumEje="${pageParamEje.pageTotal}" title="페이지 맨 뒤로 이동" class="pagingLink"><span></span> ›› </a></li>
	</c:if>
</ul>
</div>
<script type="text/javascript">
$(function(){
	$(".pagingLink", "#pagingEje").click(paging.moveLink);
});
</script>
