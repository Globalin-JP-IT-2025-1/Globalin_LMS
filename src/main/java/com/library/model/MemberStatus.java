package com.library.model;

public enum MemberStatus {

    NON_REGULER_MEM(0, "준회원", false),
    REGULER_MEM(1, "정회원", false),
    SUSPENDED(2, "대출정지", false),
    WITHDRAWN(3, "탈퇴회원", false),
    NON_REGULER_MEM_AUTO(5, "준회원 (자동 로그인)", true),
    REGULER_MEM_AUTO(6, "정회원 (자동 로그인)", true),
    SUSPENDED_AUTO(7, "대출정지 (자동 로그인)", true),
    ADMIN(9, "관리자", false),
    ADMIN_AUTO(8, "관리자 (자동 로그인)", true);

    private final int code;
    private final String description;
    private final boolean autoLogin;

    MemberStatus(int code, String description, boolean autoLogin) {
        this.code = code;
        this.description = description;
        this.autoLogin = autoLogin;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    public boolean isAutoLoginEnabled() {
        return autoLogin;
    }

    public static MemberStatus fromCode(int code) {
        for (MemberStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid MemberStatus code: " + code);
    }
}

