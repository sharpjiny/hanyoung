package com.hanManager;


public class Constant {
    /* 공통 코드 정의 */
    public static final String CODE_KEY = "code";
    public static final String MESSAGE_KEY = "message";
    public static final String MESSAGE_SAVE = "저장되었습니다.";
    public static final String MESSAGE_OK = "OK";
    public static final String RETUN_URL = "url";
	public static String TILES = ".tiles";
	public static String HOME_URL = "redirect:/toastGrid/search";

    public static final String OK = "0000";
    public static final String FIELD_ERROR = "1000";
    public static final String ERROR_DB = "2000";
    public static final String USE_DATA = "9999";
    public static final String USER = "2";
    public static final String ADMIN = "0";

    /* 공통 코드 type 정의 */
	public static String USER_STATE = "user_state"; // 사용자 상태
	public static String USER_ROLE = "user_role"; // 사용자 권한
	public static String MEASURE_TARGET = "measure_target"; // 업체구분
	public static String MEASURE_TYPE = "measure_type"; // 대상(측정항목)
	public static String ESTIMAT_SURTAX = "estimat_surtax"; // 수납(세금계산서 발행 여부)
	public static String MENU_USED = "menu_used"; // 메뉴
	public static String LOGS_TYPE = "logs_type"; // 로그 타입
	public static String GUBUN_LHRH = "gubun_lhRh"; // LH/RH 구분
	public static String JAB_CLASS = "jab_class"; // 작업반
	public static String WORK_TYPE = "work_type"; // 주/야간
	public static String STOCK_GUBUN = "stock_gubun"; // 재고 구분
	public static String RAW_GUBUN = "raw_gubun"; // 재고 구분
	public static String EJECTION = "ejection"; // 사출호기
	public static String VACCUM = "vaccum"; // 증착호기
	public static String IS_CHECK = "is_check"; // OK/NO
	public static String MONTHS = "months"; // OK/NO

	 /* 메뉴 */
	public static String MENU_SEARCH = "search";	// 검색
	public static String MENU_COMPANY = "company";	// 업체등록
	public static String MENU_USER = "user";	// 사용자권한
	public static String MENU_LOG = "log";	// 로그관리
	public static String MENU_UPLOAD = "upload";	// 업로드관리
	public static String MENU_LOGIN = "login";	// 로그인

	/* 로그 타입 */
	public static String LOG_TYPE_LOGIN = "login";	// 로그인
	public static String LOG_TYPE_REG = "reg";	// 등록
	public static String LOG_TYPE_MOD = "mod";	// 수정
	public static String LOG_TYPE_DEL = "del";	// 삭제
	public static String LOG_TYPE_VIEW = "view";	// 상세보기
	public static String LOG_TYPE_LIST = "list";	// 목록
	public static String LOG_TYPE_SEARCH = "search";	// 검색
	public static String LOG_TYPE_EXCEL = "excel";	// 엑셀다운
	public static String LOG_TYPE_UPLOAD = "upload";	// 엑셀업로드


}
