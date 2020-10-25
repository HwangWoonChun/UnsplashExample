# UnsplashForKaKaoPay

<tr>
  <td>목록<img src = "https://github.com/HwangWoonChun/UnsplashForKakaoPay/blob/master/image_1.png" width = 207 height = 367></td>
  <td>인증<img src = "https://github.com/HwangWoonChun/UnsplashForKakaoPay/blob/master/image_2.png" width = 207 height = 367></td>
  <td>상세<img src = "https://github.com/HwangWoonChun/UnsplashForKakaoPay/blob/master/image_3.png" width = 207 height = 367></td>
</tr>

# 기능 1. 사진목록
* 스크롤에 따라 사진이 자동으로 로드 되어야 합니다.
   * ScrollViewDelegate를 사용하여 로드
    
* 사진을 터치하면 해당 사진의 상세 화면이 나탑니다.
   * PushViewController를 통한 뷰컨트롤러 이동

# 기능 2. 사진상세보기
* 목록에서 선택한 사진을 보여 줍니다.
   * 목록에서의 indexPath와 사진 데이터를 상세로 전달 하여 노출
* 사진 이미지를 좌우로 스와이프 하여 사진 목록의 이전/다음 이미지를 볼 수 있습니다.
   * 사진상세보기 컨트롤러는 컬랙션뷰로 구성
* 닫기 시 사진 목록으로 돌아갑니다. 이 때, 상세에서 마지막으로 본 사진이 목록에 바로 나타나야 합니다.
   * 의존성을 낮추기 위해 델리게이트를 이용하여 인덱스 전달
   
# 기능 3. 사진 검색
* 키워드로 사진을 검색 할 수 있어야 합니다.
   * 텍스트 필드를 통해 키워드를 가져오고 버튼을 눌러 검색 하도록 개발
   
* 검색 후 동작은 위의 기능 1,2 와 동일 합니다.

<img src = "https://github.com/HwangWoonChun/UnsplashForKakaoPay/blob/master/image_1.png" width = 207 height = 367>
<img src = "https://github.com/HwangWoonChun/SWIFTUIRecture/blob/master/03Rect_01.png" width = 268 height = 314>
