<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 이용 안내 > 이용시간/휴관일 -->

<style>
.etc_51 {
    width:100%;
    padding-left: 40px;
    padding-bottom: 100px;
    padding-top: 5px;
}
.etc51_table{
    border-collapse: collapse;
    border: 1.8px solid var(--main-color);
    margin-bottom: 40px;
    margin-top: 10px;
}
.etc51_table th{
    width: 180px;
    height: 80px;
    border: 1.8px solid var(--main-color);
    padding-left: 20px;
    text-align: left;
    background-color: #f1f3f5;  
}
.etc51_table td{
    width: 480px;
    border: 1.8px solid var(--main-color);
    padding-left: 20px;
    text-align: left;  
}
.etc51_table .etc51_table_th {
    height: 50px;
}
.etc_51 .card {
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    padding: 25px 20px 60px 30px; 
    margin-top: 40px;
    width: 70%;
    height: 23%;
}
</style>

<div class="etc_51">
    <div class="etc_51_main card">
        <div>
            <p><i class="bi bi-bank"></i>&nbsp;<spring:message code="etc51.library1"/></p>
        </div>
        <div>
            <table class="etc51_table">
                <tr>
                    <th><spring:message code="etc51.t1"/></th>
                    <td><spring:message code="etc51.t3" htmlEscape="false"/></td>
                </tr>
                <tr>
                    <th class="etc51_table_th"><spring:message code="etc51.t2"/></th>
                    <td><spring:message code="etc51.t4"/></td>
                </tr>
            </table>
        </div>
    </div>
    
    <div class="etc_51_main card">    
        <div>
            <p><i class="bi bi-bank"></i>&nbsp;<spring:message code="etc51.library2"/></p>
        </div>
        <div>
            <table class="etc51_table">
                <tr>
                    <th><spring:message code="etc51.t1"/></th>
                    <td><spring:message code="etc51.t3" htmlEscape="false"/></td>
                </tr>
                <tr>
                    <th class="etc51_table_th"><spring:message code="etc51.t2"/></th>
                    <td><spring:message code="etc51.t4"/></td>
                </tr>
            </table>
        </div>
    </div>    
    
    <div class="etc_51_main card">    
        <div>
            <p><i class="bi bi-bank"></i>&nbsp;<spring:message code="etc51.library3"/></p>
        </div>
        <div>
            <table class="etc51_table">
                <tr>
                    <th><spring:message code="etc51.t1"/></th>
                    <td><spring:message code="etc51.t3" htmlEscape="false"/></td>
                </tr>
                <tr>
                    <th class="etc51_table_th"><spring:message code="etc51.t2"/></th>
                    <td><spring:message code="etc51.t4"/></td>
                </tr>
            </table>
        </div>    
    </div>
</div>
