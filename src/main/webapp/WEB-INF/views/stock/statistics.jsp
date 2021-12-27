<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">原材料出入库现况</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <div class="alert alert-block">
                    <form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
                        <fieldset>
                            <div class="control-group">
                            <label class="control-label" for="inputError">种类</label>
                            <div class="controls">
                                <select id="selectKind" name="kind" title="种类">
                                    <c:forEach items="${kinds}" var="item">
                                        <c:set var="selected" value="selected"/>
                                        <c:choose>
                                        <c:when test='${item.kind eq pageParam.kind}'><option value="${item.kind}" ${selected}>${item.kind}</option></c:when>
                                        <c:otherwise>
                                            <option value="${item.kind}" <c:if test='${pageParam.kind eq null && item.kind eq "完成品"}'> ${selected} </c:if>>${item.kind}</option>
                                        </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                                &nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-primary">검색</button></span>
                            </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            
        
	        <div class="navbar navbar-inner block-header">
	            <div class="muted pull-left">재고 현황</div>
		        <button type="button" class="btn btn-warning btn-excel" onclick="paging.excel('statisticsExcel')" style="margin-left: 10px;">엑셀다운로드 <i class="icon-download-alt icon-white"></i></button>
	        </div>

            	<%-- <div class="alert alert-block">
					<form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
						<fieldset>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">정렬</label>
	                            <div class="controls">
	                                <select id="orderBy" name="orderBy" title="정렬" onc>
	                                    <option value="">정렬</option>
	                                    <c:set var="selected" value=""/>
										<c:if test='${"b.client"==pageParam.orderBy}'><c:set var="selected" value="selected"/></c:if>
	                                    <option value="b.client" ${selected} >고객사</option>
	                                    <c:set var="selected" value=""/>
										<c:if test='${"b.kind"==pageParam.orderBy}'><c:set var="selected" value="selected"/></c:if>
	                                    <option value="b.kind" ${selected} >종류</option>
	                                    <c:set var="selected" value=""/>
										<c:if test='${"b.model_car"==pageParam.orderBy}'><c:set var="selected" value="selected"/></c:if>
	                                    <option value="b.model_car" ${selected} >차종</option>
	                                    <c:set var="selected" value=""/>
										<c:if test='${"b.product_name"==pageParam.orderBy}'><c:set var="selected" value="selected"/></c:if>
	                                    <option value="b.product_name" ${selected} >품명</option>
	                                    <c:set var="selected" value=""/>
										<c:if test='${"b.lh_rh"==pageParam.orderBy}'><c:set var="selected" value="selected"/></c:if>
	                                    <option value="b.lh_rh" ${selected} >L/R</option>
	                                </select>
	                            </div>
	                        </div>
						</fieldset>
					</form>
				</div> --%>
                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>상태</th>
                            <th>종류</th>
                            <th>고객사</th>
                            <th>차종</th>
                            <th>품명</th>
                            <th>L/R</th>
                            <th>품호</th>
                            <c:if test="${userSession.id eq 'bogoadmin'}">
                            <th>단가</th>
                            </c:if>
                            <th>수량</th>
                            <c:if test="${userSession.id eq 'bogoadmin'}">
                            <th>금액</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingList}">
						<c:set var="loopIndex" value="${pageParam.startNum}"/>
						<c:set var="totMoney" value="0" />
						<c:set var="totQuan" value="0" />
							<c:forEach items="${pagingList}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
					                <td class="center">${item.status}</td>
					                <td class="center">${item.kind}</td>
					                <td class="center">${item.client}</td>
					                <td class="center">${item.model_car}</td>
					                <td>${item.product_name}</td>
					                <td class="center">${item.lh_rh}</td>
					                <td class="center">${item.product_id}</td>
					                <c:if test="${userSession.id eq 'bogoadmin'}">
					                <td class="center"><fmt:formatNumber value="${item.price}" pattern="#.##" /></td>
					                </c:if>
					                <td class="center"><fmt:formatNumber value="${item.total_quantity}" pattern="#,###" /></td>
					                <c:if test="${userSession.id eq 'bogoadmin'}">
					                <td class="center">
					                <c:if test="${item.money ne 0}"><fmt:formatNumber value="${item.money}" pattern="#,###.00" /></c:if>
	                                <c:if test="${item.money eq 0}">0</c:if>
	                                </td>
					                </c:if>
					            </tr>
                                <c:set var="totQuan" value="${totQuan + item.total_quantity}"/>
					            <c:set var="totMoney" value="${totMoney + item.money}"/>
					        </c:forEach>
					        <c:if test="${userSession.id eq 'bogoadmin'}">
					        <tr class="error">
                                <td class="center" colspan="9">合計</td>
                                <td class="center"><fmt:formatNumber value="${totQuan}" pattern="#,###" /></td>
                                <td class="center"><fmt:formatNumber value="${totMoney}" pattern="#,###.##" /></td>
                            </tr>
                            </c:if>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="8" class="center bin">데이터가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
    <!-- /block -->
