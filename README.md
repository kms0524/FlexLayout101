# ⚙️ FlexLayout
이 저장소는 [FlexLayout](https://github.com/layoutBox/FlexLayout)에 대해 공부한 내용들을 정리 및 실습한 프로젝트를 보관한 저장소입니다.

현재 생각해놓은 개인 프로젝트와 여러 회사, 프로젝트에서 [SnapKit](https://github.com/SnapKit/SnapKit)과 더불어 레이아웃과 관련되어 가장 많이 사용되느 프레임워크 입니다. 기왕 공부할거, GitHub도 꾸미는 것도 연습해보고, TIL도 정리하고... 일석이조로 해보죠! 
<p align="center">
  <img height="300" src="https://github.com/layoutBox/FlexLayout/raw/master/docs_markdown/images/flexlayout-logo-text.png">
</p>

### 08/23
기본적인 StackView를 만들어서 구현해봤다. 공식문서에 있는 튜토리얼을 따라해보려 했으나, 하나하나 가지고 놀아보기에는 너무 복잡한 감이 있기에 기초적인 메소드들만 가지고 놀아보기에 적합한 playground를 만들어봤다! 확실히 UIStackView로 만드는것보단 훨씨 간편해보이는듯...

### 8/24
가장 중요한 메소드들 먼저 정리하면서 플레이그라운드로 이것저것 만져봤는데, 생각보다 구현이 쉬워서 원하는 뷰를 구성할 수 있을지도...? 이걸 왜 이제 알았을까... 😢

## Axis
FlexContainer를 다루기 위해서 일단 기본축(axis)의 방향을 먼저 생각해놔야한다. 기본값으로는 세로축방향이 설정되며(column) 가로축방향으로도 변경이 가능하다(row). 기본축의 방향으 설정했다면, 나머지 축이 교차축(cross axis)이 된다.

## Start
View 파일을 생성한 다음, rootFlexContainer 라는 상수명으로 UIView르 만든다.
rootFlexContainer는 여러개의 UIView 들을 담을 수 있는 말 그대로의 컨테이너의 역할을 수행한다.
rootFlexContainer(이하 컨테이너) 안에 들어갈 UIView(이하 뷰)들의 내용(이미지, 텍스트)과 위치정보를 설정해주어야 하는데
UIKit에 내장된 addSubView() 메소드르 이용하여 내용을 담는것이 가능하고, 위치정보는 FlexLayout 라이브러리에 내장된 여러 함수들로 컨테이너의 위치와 안에 들어있는 뷰들의 위치 모두 수정가능하다.(물론 init()에 모두 몰아서 쓰는것도 가능하다!)

## .define()
컨테이너를 구성할 때 써야하는 말 그대로의 "정의" 하는 메소드이다. 클로저 안의 파라미터로는 flex(box) 가 들어가며, 사용 예시는 아래와 같다.
![image](https://user-images.githubusercontent.com/48994081/186370939-9b84b645-d64d-40d7-a85a-71427cddb25d.png)

## .pin() (PinLayout)
FlexLayout 라이브러리가 아닌 같이 쓰면 좋은(사실상 필수지만...) PinLayout에 있는 메소드로서, layoutSubViews() 혹은, viewDidLayoutSubviews()에서 컨테이너의 레이아웃을 잡아주는 메소드이다. 

## .layout()
컨테이너 안의 뷰들(child)의 레이아웃을 잡아주는 메소드이다. 파라미터로는 fitContainer, adjustWidth, adjustHeight 이 있으며, 기본값으로는 fitContainer이 적용되어있다.
각 파라미터들에 대해 설명하자면,
- fitContainer : 컨테이너 내부의 뷰들은 컨테이너의 사이즈(width, hegith) <b>안에</b> 레이아웃된다. 
- adjustHeight : 컨테이너의 <b>width</b> 만 사용하여 레아아웃시킨다. height은 컨테이너내부의 뷰들에 맞게 조정된다.
- adjustWidth : 컨테이너의 <b>height</b> 만 사용하여 레아아웃시킨다. width은 컨테이너내부의 뷰들에 맞게 조정된다.

아래 그림은 각각 fitContainer, adjustHeight, adjustWidth 를 사용했을떄의 화면이다.

<p float="middle">
<img width="250" src = "https://user-images.githubusercontent.com/48994081/186393264-e7cccb37-13bd-40c7-b3cb-ed291ffff438.png" />
<img width="250" src = "https://user-images.githubusercontent.com/48994081/186394101-9dd137f9-d207-4dac-93c3-7509836a4d42.png" />
<img width="250" src = "https://user-images.githubusercontent.com/48994081/186394189-28bf2564-f270-4982-a63f-3c7622aebdd5.png" />
</p>

## .direction()
뷰의 기본축을 설정하는 메소드이다. direction(.column)은 세로축, direction(.row)은 가로축을 기본축으로 설정한다. 생략이 가능한 메소드이며, 생략할 시 direction(.column)이 자동으로 적용된다.

## .addItem()
컨테이너안에 뷰를 넣는 메소드로, 컨테이너 안에 여러겹으로 구성된 뷰를 구성할 수 있다.(UIStackView를 대체하려고 만들어진거니깐 당연히...)

## Paddings (.padding(), .paddingTop() .paddingBottom() .paddingLeft() .paddingRight() etc...)
컨테이너 내부의 뷰들에게 패딩(offset)을 부여하는 메소드이다.

컨테이너 자체의 패딩은 이 메소드로는 부여할 수 없다. 파라미터로는 CGFLoat을 사용한 절대값과, FPercent를 사용한 상대값 모두 적용 가능하다.

또한, UIView.safeAreaInsets, UIView.directionalLayoutMargins 들을 파라미터로도 활용 가능하고, vertical, horizontal 등등 여러 방향으로 적용가능하다.

모든 Padding 메소드들은 [공식문서](https://github.com/layoutBox/FlexLayout#paddings)에 나와있다.


