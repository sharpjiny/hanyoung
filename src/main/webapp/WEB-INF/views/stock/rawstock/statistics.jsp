<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">원재료재고 현황</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>种类</th><%--종류 --%>
                            <th style="display:none;">入库社</th><%--입고처 --%>
                            <th>品名</th><%--품명 --%>
                            <th style="display:none;">단가</th><%--단가 --%>
                            <th>重量</th><%--중량 --%>
                            <th style="display:none;">금액</th><%--금액 --%>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty list}">
						<c:set var="loopIndex" value="${pageParam.startNum}"/>
						<c:set var="totWeight" value="0"/>
						<c:set var="totRealPrice" value="0"/>
							<c:forEach items="${list}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
					                <td>${item.kind}</td>
					                <td style="display:none;" class="center">${item.client}</td>
									<td>${item.productName}</td>
									<td style="display:none;" class="center">
									<c:if test="${item.price ne 0}"><fmt:formatNumber value="${item.price}" pattern="#,###.00" /></c:if>
                                    <c:if test="${item.price eq 0}">0</c:if>
                                    </td>
									<td class="center"><fmt:formatNumber value="${item.weight}" pattern="#,###" /></td>
									<%-- <td class="center"><fmt:formatNumber value="${item.realPrice}" pattern="#,###.00" /></td> --%>
									<td style="display:none;" class="center">
									<c:if test="${item.realPrice ne 0}"><fmt:formatNumber value="${item.realPrice}" pattern="#,###.00" /></c:if>
                                    <c:if test="${item.realPrice eq 0}">0</c:if>
                                    </td>
					            </tr>
					            <c:set var="totWeight" value="${totWeight + item.weight}"/>
					            <c:set var="totRealPrice" value="${totRealPrice + item.realPrice}"/>
					        </c:forEach>
					        <tr class="error">
                                <td class="center" colspan="3">合計</td>
                                <td class="center"><fmt:formatNumber value="${totWeight}" pattern="#,###.00" /></td>
                                <td style="display:none;" class="center"><fmt:formatNumber value="${totRealPrice}" pattern="#,###.00" /></td>
                            </tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="4" class="center bin">데이터가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>