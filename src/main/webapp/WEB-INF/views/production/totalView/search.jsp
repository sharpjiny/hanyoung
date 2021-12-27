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
									<input class="input-small date" name="dateStart" id="dateStart" type="text" value="${pageParamEje.dateStart}">
									~
									<input class="input-small date" name="dateEnd" id="dateEnd" type="text" value="${pageParamEje.dateEnd}">
								</div>
							</div>
							<div class="control-group btn-group">
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
                            <th rowspan="2">白<br>/<br>夜<br>班</th>
                            <th rowspan="2">班</th>
                            <th rowspan="2">注塑<br>机号</th>
                            <th rowspan="2">开始<br>时间</th>
                            <th rowspan="2">结束<br>时间</th>
                            <th rowspan="2">工作<br>时间</th>
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
                            <th rowspan="2">不<br>良<br>率</th>
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
						<c:when test="${!empty listEje}">
							<c:set var="len" value="0"/>
							<c:set var="totalUseWeight" value="0"/>
							<c:set var="production" value="0"/>
							<c:set var="complete" value="0"/>
							<c:set var="faulty" value="0"/>
							<c:set var="faultyA" value="0"/>
							<c:set var="faultyB" value="0"/>
							<c:set var="faultyC" value="0"/>
							<c:set var="faultyD" value="0"/>
							<c:set var="faultyE" value="0"/>
							<c:set var="faultyF" value="0"/>
							<c:set var="faultyG" value="0"/>
							<c:set var="faultyH" value="0"/>
							<c:set var="faultyI" value="0"/>
							<c:set var="faultyJ" value="0"/>
							<c:set var="faultyK" value="0"/>
							<c:set var="prevCode" value=""/>
							<c:set var="sumTime" value="0"/>
							<c:set var="avgTime" value="00:00"/>
							<c:forEach items="${listEje}" var="item" varStatus="loop">
								<c:set var="averageWeight" value="${(item.weight1+item.weight2+item.weight3)/3}"/>
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
									<c:if test="${prevCode!=item.e_id}">
									<c:set var="len" value="${len+1}"/>
									<c:set var="sumTime" value="${sumTime+item.unix_time}"/>
									<c:set var="useWeight" value="${averageWeight*item.total_production}"/>
									<c:set var="totalUseWeight" value="${totalUseWeight + useWeight}"/>
									
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
					                <%-- <td class="center"><fmt:formatNumber value="${useWeight}" pattern="#,###.00" /></td>
					                <td class="center"><fmt:formatNumber value="${item.cycle_time}" pattern="#,###" /></td> --%>
					                <td class="center"><fmt:formatNumber value="${item.production}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.complete}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.defect_rate}" pattern="#.##"/>%</td>
					                <c:choose>
					                   <c:when test="${item.faulty_a!=0}">
					                        <td class="center"><fmt:formatNumber value="${item.faulty_a}" pattern="#,###" /></td>
					                   </c:when>
					                   <c:otherwise>
					                       <td class="center"></td>
					                   </c:otherwise>
					                </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_b!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_b}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_c!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_c}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_d!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_d}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_e!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_e}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_f!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_f}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_g!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_g}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_h!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_h}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_i!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_i}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
					                <c:choose>
                                       <c:when test="${item.faulty_j!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_j}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_k!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_k}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
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
								<c:set var="production" value="${production + item.production}"/>
								<c:set var="complete" value="${complete + item.complete}"/>
								<c:set var="faulty" value="${faulty + item.faulty}"/>
								<c:set var="faultyA" value="${faultyA + item.faulty_a}"/>
								<c:set var="faultyB" value="${faultyB + item.faulty_b}"/>
								<c:set var="faultyC" value="${faultyC + item.faulty_c}"/>
								<c:set var="faultyD" value="${faultyD + item.faulty_d}"/>
								<c:set var="faultyE" value="${faultyE + item.faulty_e}"/>
								<c:set var="faultyF" value="${faultyF + item.faulty_f}"/>
								<c:set var="faultyG" value="${faultyG + item.faulty_g}"/>
								<c:set var="faultyH" value="${faultyH + item.faulty_h}"/>
								<c:set var="faultyI" value="${faultyI + item.faulty_i}"/>
								<c:set var="faultyJ" value="${faultyJ + item.faulty_j}"/>
								<c:set var="faultyK" value="${faultyK + item.faulty_k}"/>
					            <c:set var="prevCode" value="${item.e_id}"/>
					            <c:set var="avgTime" value="${item.avgTime}"/>
					        </c:forEach>
					        <tr style="background-color: #f2dede">
				                <td class="center" colspan="7">합계</td>
				                <td class="center">
				                ${avgTime}
				                <%-- <fmt:formatNumber value="${sumTime/len}" pattern="#,###.##"/> --%>
				                </td>
				                <td colspan="5"></td>
				                <!--
				                <td class="center"><fmt:formatNumber value="${totalUseWeight}" pattern="#,###.00" /></td>
				                <td colspan="5"></td>
				                -->
				                <td class="center"><fmt:formatNumber value="${production}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${complete}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faulty}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faulty/production*100}" pattern="#.##"/>%</td>
				                <td class="center"><fmt:formatNumber value="${faultyA}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyB}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyC}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyD}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyE}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyF}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyG}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyH}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyI}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyJ}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${faultyK}" pattern="#,###" /></td>
				                <!-- <td class="center"></td> -->
				        	</tr>
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
                <table cellpadding="1" cellspacing="1" border="1" style="border-color:#ddd; width:100%;" class="table-hover table-striped">
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
                            <!-- <th rowspan="2">확인</th> -->
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${!empty listVac}">
                            <c:set var="len" value="0"/>
                            <c:set var="totalUseWeight" value="0"/>
                            <c:set var="totalUseTunc" value="0"/>
                            <c:set var="production" value="0"/>
                            <c:set var="complete" value="0"/>
                            <c:set var="prevCode" value=""/>
                            <c:set var="sumTime" value="0"/>
                            <c:set var="avgTime" value="00:00"/>
                            <c:forEach items="${listVac}" var="item" varStatus="loop">
                                <tr>
                                    <td class="center"><span>${loopIndex+loop.count}</span></td>
                                    <c:if test="${prevCode!=item.e_id}">
                                    <c:set var="len" value="${len+1}"/>
                                    <c:set var="sumTime" value="${sumTime+item.unix_time}"/>
                                    <c:set var="useWeight" value="${item.total_production}"/>
                                    <c:set var="tuncUsed" value="${item.tunc_used}"/>
                                    <c:set var="totalUseWeight" value="${totalUseWeight + useWeight}"/>
                                    <c:set var="totalUseTunc" value="${totalUseTunc + tuncUsed}"/>
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
                                <c:set var="production" value="${production + item.production}"/>
                                <c:set var="complete" value="${complete + item.complete}"/>
                                <c:set var="prevCode" value="${item.e_id}"/>
                                <c:set var="avgTime" value="${item.avgTime}"/>
                            </c:forEach>
                            <tr style="background-color: #f2dede">
                                <td class="center" colspan="7">합계</td>
                                <td class="center">
                                ${avgTime}
                                <%-- <fmt:formatNumber value="${sumTime/len}" pattern="#,###.##"/> --%>
                                </td>
                                <td colspan="5"></td>
                                <td class="center"><fmt:formatNumber value="${totalUseWeight}" pattern="#,###" /></td>
                                <td class="center"><fmt:formatNumber value="${totalUseTunc}" pattern="#,###" /></td>
                                <!-- <td colspan="2"></td> -->
                            </tr>
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
                <table cellpadding="1" cellspacing="1" border="1" style="border-color:#ddd; width:100%;" class="table-hover table-striped">
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
                            <th>白点<br>/<br>黑点</th>
                            <th>断裂</th>
                            <th>多镀</th>
                            <th>送检</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${!empty listIns}">
                            <c:set var="production" value="0"/>
                            <c:set var="complete" value="0"/>
                            <c:set var="faulty" value="0"/>
                            <c:set var="faultyA" value="0"/>
                            <c:set var="faultyB" value="0"/>
                            <c:set var="faultyC" value="0"/>
                            <c:set var="faultyD" value="0"/>
                            <c:set var="faultyE" value="0"/>
                            <c:set var="faultyF" value="0"/>
                            <c:set var="faultyG" value="0"/>
                            <c:set var="faultyH" value="0"/>
                            <c:set var="faultyI" value="0"/>
                            <c:set var="faultyJ" value="0"/>
                            <c:set var="faultyK" value="0"/>
                            <c:set var="faultyL" value="0"/>
                            <c:forEach items="${listIns}" var="item" varStatus="loop">
                                <tr>
                                    <td class="center"><span>${loop.count}</span></td>
                                    <td class="center">${item.inspection_date}</td>
                                    <td class="center">${item.jab_class_name}</td>
                                    <td class="center">${item.work_type_name}</td>
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
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_b!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_b}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_c!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_c}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_d!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_d}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_e!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_e}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_f!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_f}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_g!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_g}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_h!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_h}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_i!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_i}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_j!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_j}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_k!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_k}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                       <c:when test="${item.faulty_l!=0}">
                                            <td class="center"><fmt:formatNumber value="${item.faulty_l}" pattern="#,###" /></td>
                                       </c:when>
                                       <c:otherwise>
                                           <td class="center"></td>
                                       </c:otherwise>
                                    </c:choose>
                                    <%-- <td class="center">
                                    <c:choose>
                                    <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
                                    <c:otherwise>${item.is_check}</c:otherwise>
                                    </c:choose>
                                    </td> --%>
                                </tr>
                                <c:set var="production" value="${production + item.production}"/>
                                <c:set var="complete" value="${complete + item.complete}"/>
                                <c:set var="faulty" value="${faulty + item.faulty}"/>
                                <c:set var="faultyA" value="${faultyA + item.faulty_a}"/>
                                <c:set var="faultyB" value="${faultyB + item.faulty_b}"/>
                                <c:set var="faultyC" value="${faultyC + item.faulty_c}"/>
                                <c:set var="faultyD" value="${faultyD + item.faulty_d}"/>
                                <c:set var="faultyE" value="${faultyE + item.faulty_e}"/>
                                <c:set var="faultyF" value="${faultyF + item.faulty_f}"/>
                                <c:set var="faultyG" value="${faultyG + item.faulty_g}"/>
                                <c:set var="faultyH" value="${faultyH + item.faulty_h}"/>
                                <c:set var="faultyI" value="${faultyI + item.faulty_i}"/>
                                <c:set var="faultyJ" value="${faultyJ + item.faulty_j}"/>
                                <c:set var="faultyK" value="${faultyK + item.faulty_k}"/>
                                <c:set var="faultyL" value="${faultyL + item.faulty_l}"/>
                            </c:forEach>
                                <tr style="background-color: #f2dede">
                                    <td class="center" colspan="8">합계</td>
                                    <td class="center"><fmt:formatNumber value="${production}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${complete}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faulty}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faulty/production*100}" pattern="#.##"/>%</td>
                                    <td class="center"><fmt:formatNumber value="${faultyA}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyB}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyC}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyD}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyE}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyF}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyG}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyH}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyI}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyJ}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyK}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${faultyL}" pattern="#,###" /></td>
                                    <!-- <td class="center"></td> -->
                                </tr>
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
var ejectionList ={
	ejectionCheck: function(){
		var $this = $(this);
		var eId = $this.attr('eId');
		if(!eId) return;
		if(!confirm('확인하시겠습니까?')) return;

		$.ajax({
			url: '/ejection/ejectionCheckAjax',
			type: 'POST',
			data: {eId: eId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				$this.closest('td').text('OK');
			}
		}).fail(function() {
	    	alert( '확인에 실패했습니다' );
	    });
	},

	selectKind : function(){
	    var kind = $(this).val();
	    if(kind){
	        $.ajax({
	            url: '/vehicle/selectModelCarsAjax',
	            type: 'POST',
	            data: {kind: kind}
	        }).success(function( data ) {
	            if(data.list){
	                var $selectModelCar = $('#selectModelCar').find('option:not(:eq(0))').remove().end();
	                $.each(data.list, function(i, item){
	                    $selectModelCar.append($('<option/>').val(item.model_car).text(item.model_car));
	                });
	                $selectModelCar.prop('disabled', false);
	                $('.selectVehicle:not(#selectKind):not(#selectModelCar)').prop('disabled', true).find('option[value=""]').prop('selected', true);
	            }
	        }).fail(function() {
	            alert( '데이터 조회에 실패했습니다' );
	            $('.selectVehicle:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
	        });
	    }else{
	        $('.selectVehicle:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
	    }
	},

	selectModelCar : function(){
        var kind = $('#selectKind').val();
        var modelCar = $(this).val();
        if(kind && modelCar){
            $.ajax({
                url: '/vehicle/selectProductNamesAjax',
                type: 'POST',
                data: {kind: kind, modelCar : modelCar}
            }).success(function( data ) {
                if(data.list){
                    var $selectProductName = $('#selectProductName').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectProductName.append($('<option/>').val(item.product_name).text(item.product_name));
                    });
                    $selectProductName.prop('disabled', false);
                    $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
                }
            }).fail(function() {
                alert( '데이터 조회에 실패했습니다' );
                $('#selectProductName, #selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
            });
        }else{
            $('#selectProductName, #selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
        }
    },

   selectProductName : function(){
        var kind = $('#selectKind').val();
        var modelCar = $('#selectModelCar').val();
        var productName = $(this).val();
        if(kind && modelCar && productName){
            $.ajax({
                url: '/vehicle/selectlhRhsAjax',
                type: 'POST',
                data: {kind: kind, modelCar : modelCar, productName : productName}
            }).success(function( data ) {
                if(data.list){
                    var $selectLhRh = $('#selectLhRh').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectLhRh.append($('<option client="'+item.client+'" vehicleId="'+item.vehicle_id+'"/>').val(item.lh_rh).text(item.lh_rh));
                    });
                    $selectLhRh.prop('disabled', false);
                }
            }).fail(function() {
                alert( '데이터 조회에 실패했습니다' );
                $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
            });
        }else{
            $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
        }
    },

    selectLhRh : function(){
        var kind = $('#selectKind').val();
        var modelCar = $('#selectModelCar').val();
        var productName = $('#selectProductName').val();
        var lhRh = $(this).val();
        if(kind && modelCar && productName && lhRh){
            $.ajax({
                url: '/production/ejection/selectRawStocksAjax',
                type: 'POST',
                data: {kind: kind, modelCar : modelCar, productName : productName, lhRh : lhRh}
            }).success(function( data ) {
                if(data.list){
                    var $selectRawStock = $('#selectRawStock').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectRawStock.append($('<option/>').val(item.raw_product_id).text(item.raw_product_name));
                    });
                    $selectRawStock.prop('disabled', false);
                }
            }).fail(function() {
                alert( '데이터 조회에 실패했습니다' );
                $('#selectRawStock').prop('disabled', true).find('option:not(:eq(0))').remove();
            });
        }else{
            $('#selectRawStock').prop('disabled', true).find('option:not(:eq(0))').remove();
        }
    }
}

$(function(){
	dateUtil.init();
	$('.isCheckBtn').click(ejectionList.ejectionCheck);
	$('#selectKind').change(ejectionList.selectKind);
    $('#selectModelCar').change(ejectionList.selectModelCar);
    $('#selectProductName').change(ejectionList.selectProductName);
    $('#selectLhRh').change(ejectionList.selectLhRh);
});
</script>