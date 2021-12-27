<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">生产日报</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
				<div class="alert alert-block">
					<form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="dateStart">日期</label>
								<div class="controls">
									<input class="input-small date" name="dateStart" id="dateStart" type="text" value="${pageParam.dateStart}">
									~
									<input class="input-small date" name="dateEnd" id="dateEnd" type="text" value="${pageParam.dateEnd}">
								</div>
							</div>
							<div class="control-group btn-group">
								<input type="hidden" name="pageCutEje" value="10"/>
								<input type="hidden" name="pageNumEje" value="${pageParamEje.pageNum}"/>
								<input type="hidden" name="pageCutVac" value="10"/>
                                <input type="hidden" name="pageNumVac" value="${pageParamVac.pageNum}"/>
                                <input type="hidden" name="pageCutIns" value="10"/>
                                <input type="hidden" name="pageNumIns" value="${pageParamIns.pageNum}"/>
								<button type="submit" class="btn btn-primary">Search</button>
							</div>
						</fieldset>
					</form>
				</div>
				<p><h4>注塑</h4></p>
				<div class="tableScroll">
                <!-- <table cellpadding="1" cellspacing="1" border="1" style="border-color:#ddd; width:100%;" class="table-hover table-striped"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th rowspan="2">NO</th>
                            <th rowspan="2">日期</th>
                            <th rowspan="2">白/夜班</th>
                            <th rowspan="2">班</th>
                            <th rowspan="2">注塑机号</th>
                            <th rowspan="2">开始时间</th>
                            <th rowspan="2">结束时间</th>
                            <th rowspan="2">工作时间</th>
                            <th rowspan="2">种类</th>
                            <th rowspan="2">车种</th>
                            <th rowspan="2">品名</th>
                            <th rowspan="2">L/R</th>
                            <th rowspan="2">品号</th>
                            <!-- <th rowspan="2">원재료종류</th>
                            <th rowspan="2">원재료명</th> -->
                            <th rowspan="2">生产<br>数量</th>
                            <th rowspan="2">良品<br>数量</th>
                            <th rowspan="2">不良<br>数量</th>
                            <th rowspan="2">不良率</th>
                            <th colspan="11">不良类型</th>
                            <!-- <th rowspan="2">확인</th> -->
                        </tr>
                        <tr>
                        	<th>开机<br>不良</th>
                            <th>调机<br>不良</th>
                            <th>未<br>成形</th>
                            <th>银丝</th>
                            <th>气泡</th>
                            <th>擦模</th>
                            <th>黑点</th>
                            <th>杂料</th>
                            <th>油斑<br>/<br>气斑</th>
                            <th>断裂</th>
                            <th>脏斑</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingListEje}">
						<c:set var="loopIndex" value="${pageParamEje.startNum}"/>
							<c:set var="prevCode" value=""/>
							<c:forEach items="${pagingListEje}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
									<c:if test="${prevCode!=item.e_id}">
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.ejection_date}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.work_type_name}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.ejection_group_name}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.ejection_name}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.start_time}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.end_time}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.d_time}</td>
						            </c:if>
					                <td>${item.kind}</td>
					                <td>${item.model_car}</td>
					                <td>${item.product_name}</td>
					                <td class="center">${item.lh_rh}</td>
					                <td>${item.product_id}</td>
							<%-- <td>${item.raw_kind}</td>
					                <td>${item.raw_product_name}</td> --%>
					                
					                <td class="center"><fmt:formatNumber value="${item.production}" pattern="#,###" /></td>
					                
					                <td class="center"><fmt:formatNumber value="${item.complete}" pattern="#,###" /></td>
					                
					                <td class="center"><fmt:formatNumber value="${item.faulty}" pattern="#,###" /></td>
					                
					                <td class="center"><fmt:formatNumber value="${item.defect_rate}" pattern="#.##"/>%</td>
					                <c:choose>
					                <c:when test="${item.faulty_a!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_a}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_b!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_b}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_c!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_c}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_d!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_d}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_e!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_e}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_f!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_f}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_g!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_g}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_h!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_h}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_i!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_i}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_j!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_j}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <c:choose>
					                <c:when test="${item.faulty_k!=0}">
					                <td class="center"><fmt:formatNumber value="${item.faulty_k}" pattern="#,###" /></td>
					                </c:when>
					                <c:otherwise><td class="center"></td></c:otherwise>
					                </c:choose>
					                <%-- <c:choose>
									<c:when test="${prevCode!=item.e_id}">
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">
										<c:choose>
							                <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
							                <c:otherwise>${item.is_check}</c:otherwise>
						                </c:choose>
					                </td>
						            </c:when>
									</c:choose> --%>
					            </tr>
					            <c:set var="prevCode" value="${item.e_id}"/>
					        </c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="28" class="center bin">NO DATA.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
                </div>
                <p><h4>镀铝</h4></p>
                <div class="tableScroll">
                <!-- <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>日期</th>
                            <th>白/夜班</th>
                            <th>班</th>
                            <th>镀铝机号</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>工作时间</th>
                            <th>种类</th>
                            <th>车种</th>
                            <th>品名</th>
                            <th>L/R</th>
                            <th>品号</th>
                            <th>生产<br>数量</th>
                            <th>钨丝<br>使用量</th>
                            <!-- <th>확인</th> -->
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${!empty pagingListVac}">
                        <c:set var="loopIndex" value="${pageParamVac.startNum}"/>
                            <c:set var="prevCode" value=""/>
                            <c:forEach items="${pagingListVac}" var="item" varStatus="loop">
                                <tr>
                                    <td class="center"><span>${loopIndex+loop.count}</span></td>
                                    <c:if test="${prevCode!=item.e_id}">
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.vaccum_date}</td>
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.work_type_name}</td>
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.vaccum_group_name}</td>
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.vaccum_name}</td>
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.start_time}</td>
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.end_time}</td>
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">${item.d_time}</td>
                                    </c:if>
                                    <td>${item.kind}</td>
                                    <td>${item.model_car}</td>
                                    <td>${item.product_name}</td>
                                    <td class="center">${item.lh_rh}</td>
                                    <td>${item.product_id}</td>
                                    <td class="center"><fmt:formatNumber value="${item.production}" pattern="#,###" /></td>
                                    <c:if test="${prevCode!=item.e_id}">
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center"><fmt:formatNumber value="${item.tunc_used}" pattern="#,###" /></td>
                                    </c:if>
                                    <%-- <c:choose>
                                    <c:when test="${prevCode!=item.e_id}">
                                    <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">
                                        <c:choose>
                                            <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
                                            <c:otherwise>${item.is_check}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    </c:when>
                                    </c:choose> --%>
                                </tr>
                                <c:set var="prevCode" value="${item.e_id}"/>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td scope="col" colspan="15" class="center bin">NO DATA.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
                </div>
                <p><h4>组装/包装</h4></p>
                <div class="tableScroll">
                <!-- <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th rowspan="2">NO</th>
                            <th rowspan="2">日期</th>
                            <th rowspan="2">白/夜班</th>
                            <th rowspan="2">班</th>
                            <th rowspan="2">车种</th>
                            <th rowspan="2">品名</th>
                            <th rowspan="2">L/R</th>
                            <th rowspan="2">品号</th>
                            <th rowspan="2">生产数量</th>
                            <th rowspan="2">良品数量</th>
                            <th rowspan="2">不良数量</th>
                            <th rowspan="2">不良率</th>
                            <th colspan="12">镀铝, 组装不良</th>
                            <!-- <th rowspan="2">확인</th> -->
                        </tr>
                        <tr>
                            <th>送检</th>
                            <th>发黄<br>/<br>发彩</th>
                            <th>炸丝</th>
                            <th>水丝</th>
                            <th>发白</th>
                            <th>滑牙</th>
                            <th>脏斑</th>
                            <th>划伤</th>
                            <th>白/黑点</th>
                            <th>断裂</th>
                            <th>多镀</th>
                            <th>送检</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${!empty pagingListIns}">
                        <c:set var="loopIndex" value="${pageParamIns.startNum}"/>
                            <c:forEach items="${pagingListIns}" var="item" varStatus="loop">
                                <tr>
                                    <td class="center"><span>${loopIndex+loop.count}</span></td>
                                    <td class="center">${item.inspection_date}</td>
                                    <td class="center">${item.work_type_name}</td>
                                    <td class="center">${item.jab_class_name}</td>
                                    <td class="center">${item.model_car}</td>
                                    <td>${item.product_name}</td>
                                    <td class="center">${item.lh_rh}</td>
                                    <td class="center">${item.product_id}</td>
                                    <td class="center"><fmt:formatNumber value="${item.production}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${item.complete}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${item.faulty}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${item.faulty/item.production*100}" pattern="#.##"/>%</td>
                                       <c:choose>
                                       <c:when test="${item.faulty_a!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_a}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_b!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_b}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_c!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_c}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_d!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_d}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_e!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_e}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_f!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_f}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_g!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_g}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_h!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_h}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_i!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_i}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_j!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_j}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_k!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_k}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                       <c:choose>
                                       <c:when test="${item.faulty_l!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_l}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise><td class="center"></td></c:otherwise>
                                       </c:choose>
                                    <%--<td class="center">
                                    <c:choose>
                                    <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
                                    <c:otherwise>${item.is_check}</c:otherwise>
                                    </c:choose> --%>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td scope="col" colspan="24" class="center bin">NO DATA.</td>
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
</div>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<script>
$(function(){
	dateUtil.init();
});
</script>