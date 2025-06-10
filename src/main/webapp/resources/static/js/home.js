document.addEventListener('DOMContentLoaded', () => {
  // 현재 슬라이드 인덱스
  let currentSlide = 0;
  
  // 배너 트랙 요소 가져오기
  const bannerTrack = document.getElementById('bannerTrack');
  
  // 원본 배너 수 계산
  const banners = document.querySelectorAll('.banner_card');
  const originalSlides = banners.length; // 원본 배너 수 (7)
  
  // 배너 복제를 위해 원본 HTML 저장
  const originalHTML = bannerTrack.innerHTML;
  
  // 배너를 두 배로 복제하여 무한 루프 구현
  bannerTrack.innerHTML += originalHTML;
  
  // 슬라이드 이동 거리 (배너 너비 200px + 간격 30px)
  const slideWidth = 230;
  
  // 슬라이드 이동 함수
  const moveSlide = (direction) => {
    currentSlide += direction;
    bannerTrack.style.transition = "transform 0.5s ease";
    bannerTrack.style.transform = `translateX(-${currentSlide * slideWidth}px)`;
  };
  
  // 슬라이드 이동 완료 시 무한 루프 처리
  bannerTrack.addEventListener('transitionend', () => {
    if (currentSlide >= originalSlides) {
      currentSlide -= originalSlides;
      bannerTrack.style.transition = "none";
      bannerTrack.style.transform = `translateX(-${currentSlide * slideWidth}px)`;
      bannerTrack.offsetHeight; // 강제 리플로우
      bannerTrack.style.transition = "transform 0.5s ease";
    } else if (currentSlide < 0) {
      currentSlide += originalSlides;
      bannerTrack.style.transition = "none";
      bannerTrack.style.transform = `translateX(-${currentSlide * slideWidth}px)`;
      bannerTrack.offsetHeight; // 강제 리플로우
      bannerTrack.style.transition = "transform 0.5s ease";
    }
  });
  
  // 6초마다 자동 슬라이드
  let slideInterval = setInterval(() => moveSlide(1), 3000);
  
  // 마우스 오버 시 자동 슬라이드 일시 정지
  bannerTrack.addEventListener('mouseover', () => clearInterval(slideInterval));
  
  // 마우스 아웃 시 자동 슬라이드 재개
  bannerTrack.addEventListener('mouseout', () => {
    slideInterval = setInterval(() => moveSlide(1), 3000);
  });
  
  // 초기화: banner1부터 시작
  moveSlide(0);
});