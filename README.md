# ⚙️ FlexLayout
이 저장소는 [FlexLayout](https://github.com/layoutBox/FlexLayout)에 대해 공부한 내용들을 정리 및 실습한 프로젝트를 보관한 저장소입니다.

현재 생각해놓은 개인 프로젝트와 여러 회사, 프로젝트에서 [SnapKit](https://github.com/SnapKit/SnapKit)과 더불어 레이아웃과 관련되어 가장 많이 사용되느 프레임워크 입니다. 기왕 공부할거, GitHub도 꾸미는 것도 연습해보고, TIL도 정리하고... 일석이조로 해보죠! 
<p align="center">
  <img height="300" src="https://github.com/layoutBox/FlexLayout/raw/master/docs_markdown/images/flexlayout-logo-text.png">
</p>

- [What is FlexLayout](#what-is-flexlayout)
  * [Axis](#axis)
  * [Start](#start)
  * [.define()](#define)
  * [.addItem()](#additem)
  * [.pin()](#pin)
  * [.layout()](#layout)
- [컨테이너에 적용시키는 메소드들](#컨테이너에-적용시키는-메소드들)
  * [.direction()](#direction)
  * [.justifyContent()](#justifycontent)
    + [❓spaceAround 와 spaceEvenly의 차이가 뭔가요?](#-spacearound-와-spaceevenly의-차이가-뭔가요?)
  * [.alignItems()](#alignitems)
  * [.alignSelf()](#alignself)
  * [.wrap()](#wrap)
  * [.alignContent()](#aligncontent)
  * [.layoutDirection()](#layoutdirection)
- [뷰들에 적용시키는 메소드들](#뷰들에-적용시키는-메소드듣)
  * [.basis()](#basis)
  * [.grow()](#grow)
  * [.shrink()](#shrink)
  * [.isIncludeInLayout()](#isincludeinlayout)
  * [.display()](#display)
  * [.markDirty()](#markdirty)
    + [❓레이아웃을 강제로 적용시킨다는게 무슨말인가요?](#--------------------------)
  * [.sizeThatFits()](#sizethatfits)
  * [.intrinsicSize()](#intrinsicsize)
- [절대위치 관련 메소드](#절대위치-관련-메소드)
  * [.position()](#position)
  * [.top(), .bottom(), .left(), .right() ...](#topbottomleftright)
- [크기 관련 메소드](#크기-관련-메소드)
  * [.width(), .height(), .size()](#width----height----size--)
  * [.minWidth(), .maxWidth(), .minHeight(), .maxHeight()](#minwidth----maxwidth----minheight----maxheight--)
  * [.aspectRatio()](#aspectratio--)
- [마진 관련 메소드들](#마진-관련-메소드들)
  * [.marginTop(), .marginLeft(), .marginBottom(), marginRight()...](#margintop----marginleft----marginbottom----marginright--)
- [패딩 관련 메소드들](#패딩-관련-메소드들)
  * [.padding(), .paddingTop() .paddingBottom() .paddingLeft() .paddingRight()](#padding----paddingtop---paddingbottom---paddingleft---paddingright--)
- [etc](#etc)
  * [.backgroundColor()](#backgroundcolor--)



### 08/23
기본적인 StackView를 만들어서 구현해봤다. 공식문서에 있는 튜토리얼을 따라해보려 했으나, 하나하나 가지고 놀아보기에는 너무 복잡한 감이 있기에 기초적인 메소드들만 가지고 놀아보기에 적합한 playground를 만들어봤다! 확실히 UIStackView로 만드는것보단 훨씨 간편해보이는듯...

### 8/24
가장 중요한 메소드들 먼저 정리하면서 플레이그라운드로 이것저것 만져봤는데, 생각보다 구현이 쉬워서 원하는 뷰를 구성할 수 있을지도...? 이걸 왜 이제 알았을까... 😢

### 8/26
컨테이너에 우선적으로 적용되는 메소드들을 정리하였다. 이제 남은게 컨테이너와 뷰들에 적용되는 메소소드들을 정리하면된다. gorw, shrink 들을 계속해서 보니까 조금 헷갈리기도 한다... 뷰들간의 상대적이 크기로 적용이 가능한 메소드라....

### 8/27
드디어 flexlayout의 핵심인 basis, grow, shrink모두 정리하였다. 유연하게 뷰의 크기를 조정해주다니... 편리한거는 둘째치고, 만약 디자이너가 flexlayout을 알고있다면 진짜 엄청난 시너지가 나올거같다...

### 8/29
모든 정리를 마쳤다! 이제 실습으로 한번 만들어봐야지...


# What is FlexLayout?

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

## .addItem()
컨테이너안에 뷰를 넣는 메소드로, 컨테이너 안에 여러겹으로 구성된 뷰를 구성할 수 있다.(UIStackView를 대체하려고 만들어진거니깐 당연히...)

## .pin()
FlexLayout 라이브러리가 아닌 같이 쓰면 좋은(사실상 필수지만...) PinLayout에 있는 메소드로서, layoutSubViews() 혹은, viewDidLayoutSubviews()에서 컨테이너의 레이아웃을 잡아주는 메소드이다. 

## .layout()
컨테이너 안의 뷰들(child)의 레이아웃을 잡아주는 메소드이다. 파라미터로는 fitContainer, adjustWidth, adjustHeight 이 있으며, 기본값으로는 fitContainer이 적용되어있다.
각 파라미터들에 대해 설명하자면,
- fitContainer : 컨테이너 내부의 뷰들은 컨테이너의 사이즈(width, hegith) <b>안에</b> 레이아웃된다. 
- adjustHeight : 컨테이너의 <b>width</b> 만 사용하여 레아아웃시킨다. height은 컨테이너 내부의 뷰들에 맞게 조정된다.
- adjustWidth : 컨테이너의 <b>height</b> 만 사용하여 레아아웃시킨다. width은 컨테이너 내부의 뷰들에 맞게 조정된다.

아래 그림은 각각 fitContainer, adjustHeight, adjustWidth 를 사용했을떄의 화면이다.

<p float="middle">
<img width="250" src = "https://user-images.githubusercontent.com/48994081/186393264-e7cccb37-13bd-40c7-b3cb-ed291ffff438.png" />
<img width="250" src = "https://user-images.githubusercontent.com/48994081/186394101-9dd137f9-d207-4dac-93c3-7509836a4d42.png" />
<img width="250" src = "https://user-images.githubusercontent.com/48994081/186394189-28bf2564-f270-4982-a63f-3c7622aebdd5.png" />
</p>



# 컨테이너에 적용시키는 메소드들

## .direction()
뷰의 기본축을 설정하는 메소드이다. direction(.column)은 세로축, direction(.row)은 가로축을 기본축으로 설정한다. 생략이 가능한 메소드이며, 생략할 시 direction(.column)이 자동으로 적용된다.

추가적으로, 파라미터에 column/row 뿐 아니라, columnReverse/rowReverse 가 있는데, reverse라는 말 그대로 같으 축으로 설정 하되, 역순으로 설정하는 파라미터이다. column은 위에서 아래 이지만, columnReverse는 아래에서 위로 설정되고 row는 왼쪽에서 오른쪽(텍스트를 읽는 방향), rowReverse는 오른쪽에서 왼쪽으로 설정된다.

## .justifyContent()
컨테이너의 정렬 상태를 변경하는 메소스이다. 파라미터로는 start, end, center, spaceBetween, sapceAround, spaceEvenly가 있으며, 기본값으로는 start가 적용되있다. 이때, 정렬될 떄의 각각의 간격의 길이는 <b>기본축</b>을 기준으로 간격의 길이가 설정된다. 
- start : .direction()에서 설정하느 축의 시작방향으로 정렬시킨다. .column으 경우는 위쪽, .row의 경우느 왼쪽으로 정렬시킨다.
- end : start와 반대로, 축의 종료방향으로 정렬시킨다ㅣ. .column의 경우는 아래쪽, .row의 경우는 오른쪽으로 정렬시킨다.
- center : 축의 가운데로 정렬시킨다.
- spaceBetween : 첫번째 뷰와 마지막 뷰를 컨테이너의 각각 맨 끝으로 배치 한 뒤, 사이에 있는 뷰들을 같은 여백으로 배치시킨다. 쉽게말해, 아이템들의 <b>사이</b>에 동일한 간격을 설정시킨다. 이때, 간격의 길이는 기본축을 기준으로 간격의 길이가 설정된다.
- spaceAround : 모든 뷰들의 간격으 각 컨테이너와의 간격과 각 뷰자체에 할당시킬 간격을 모두 고려하여 모두 동일한 간격으로 배치시킨다.
- spaceEvenly : 컨테이너와의 간격과 뷰와 뷰 사이의 간격을 동일하게 하여 배치시킨다.

### ❓spaceAround 와 spaceEvenly의 차이가 뭔가요?

![image](https://user-images.githubusercontent.com/48994081/186833028-344a9099-f2a3-44d3-9604-803416e904fe.png)

그림의 위쪽이 spaceAround, 아래쪽이 spaceEvenly이다. spaceAround는 컨테이너와의 간격 1칸과 아이템과 아이템 사이의 간격이 컨테이너와의 간격의 2배(2칸)으로 이루어져 있는걸 볼 수 있으며, spaceEvenly는 컨테이너와 아이템의 간격 모두 2칸으로 이루어져있는것을 볼 수 있다.

## .alignItems()
위에서 설명한 justifyContent()와 비슷하지만, alignItems()은 <b>교차축</b>을 기준으로 정렬된다. 파리미터로는 stretch, start, end, center, baseline이 있으며, 기본값응로는 stretch가 적용되어있다.
- stretch : 교차축 방향으로 쭉 늘려져있게 정렬시킨다.
- start : 아이템들을 교차축의 시작방향으로 정렬시킨다.
- end : 아이템들을 교차축의 종료방향으로 정렬시킨다.
- center : 아이템들을 교차축의 가운데에 정렬시킨다.
- baseline : 아이템들을 텍스트 베이스라인을 기준으로 정렬시킨다.

## .alignSelf()
.justifyContent(), .alignItems()은 컨테이너의 정렬상태를 변경하는 메소드이지만, .alignSelf()은 컨테이너안의 <b><i>뷰</i></b>의 정렬상태를 변경하는 메소드이다. 파라미토는 .alignItems()와 동일하며, 동일하게 적용된다.

## .wrap()
컨테이너안의 뷰들을 한 줄로 담길수 없을때 사용되는 메소드로, 아이템을 줄바꿈 시켜주는 메소드이다. FlexLayout 디폴트로 모든 뷰들을 한 줄로 표현가능할 수 있다. 하지만, 만약 뷰들을 여러줄로 표현하고 싶다면? 바로 이럴때 .wrap() 메소드를 사용하는것이다. 파라미터로는 noWrap, wrap, wrapReverse가 있으며, 기본값으로는 noWrap이 적용되어있다.
- noWrap : 기본값으로 설정되어있으며, 가 뷰들을 모두 한 줄로 표현시킨다. 다만 overflow가 일어날 가능성이 있다. 
- wrap : 각 뷰들을 컨테이너 <b><i>교차축</i></b>의 <b><i>정방향</i></b>으로 overflow되는 뷰들을 줄바꿈 시켜서 배치시킨다.
- wrapReverse : wrap과 비슷하지만, <b><i>교차축</i></b>의 <b><i>역방향</i></b>으로 줄바꿈 시켜서 배치시킨다.

## .alignContent()
.wrap() 메소드를 사용하여 여러줄로 줄바꿈된 상태에서 정렬이 필요할때 사용되는 메소드이다.(이 말인 즉슨, 한 줄로 설정되어있는 경우(noWrap)에는 이 메소드를 사용해봤자, 적용이 되지 않는다.) 

.justifyContent() 메소드와 같은 파라미터들을 사용하고 있으며, 적용되는 방식도 동일하다. 

## .layoutDirection()
텍스트를 오른쪽에서 왼쪽으로 읽는 나라(언어)의 경우에 사용하는 메소드이다. 파라미터로는 inherit, ltr, rtl 이 있으며 기본값으로는 ltr이 적용되어있다.

# 뷰들에 적용시키는 메소드들
❗️ <b><i>컨테이너</i></b>도 뷰(flexbox)이기 때문에, 이 섹션에 있는 메소드들 또한 컨테이너에 적용 가능하다! ❗️

## .basis()
아이템들의 기본축을 기준으로 너비(.column의 경우) 혹은 길이(.row의 경우)를 조절하여 아이템의 기본 점유 크기를 설정하는 메소드이디. 파라미터로는 float값과, FPercent 타입으로, 절대값과 퍼센테이지 값을 넣을 수 있다. 기본값으로는 0이 들어가있으며, 자동으로 해당 아이템의 점유율을 가지지 않은 너비(길이)의 길이가 적용된다.

## .grow()
FlexLayout의 가장 큰 특징으로, 컨테이너 안의 여백의 공간들이 컨테이너(뷰)가 유연하게(Flex)되어 남은 여백 공간들을 채워지게 하는 메소드이다. 파라미터로는 float 타입이고, 기본값으로는 0이 설정되어있어서 grow를 적용시키려면 숫자를 바꿔줘야하는데, 파라미터의 숫자는 각 뷰들의 여백들의 비율을 의미한다.

## .shrink()
.grow()와 반대되는 메소드로, 여백을 강제로 줄어들게하느 메소드이다. 파라미터로는 float 타입이고, 기본 값으로느 0이 설정되어 있다. .grow()와 마찬가지로 파라미터에 0이 아니 다른 값을 넣어주면 컨테이너(뷰)가 유연하게(FLex)되어 줄어들게 되는 방식이다.

## .isIncludeInLayout()
뷰가 컨테이너의 레이아웃 <b><i>안에</i></b> 포함시킬지, 아닐지를 동적으로 설정하는 메소드이다. 파라미터로는 bool 타입이 들어간다. true를 기본값으로 설정되며, 메소드를 사용하지 않아도 자동으로 적용되나, false로 디버깅할때 확인해보는 용도로 사용해봄직하다.

## .display()
말 그대로, 아이템을 보여줄지, 아닐지를 설정하는 메소드이다. 파라미터안에 .none 값을 주면, 해당 아이템은 레이아웃에 포함되어 있지 않게되며, 사라져보이게 된다.

## .markDirty()
강제로 FlexLayout이 컨테이너(뷰)에 레이아웃을 강제로 적용되게 해줄때 사용되는 메소드이다.

### ❓레이아웃을 강제로 적용시킨다는게 무슨말인가요?
제드님의 [포스트](https://zeddios.tistory.com/1253)에 markDirty 파트에 있는 이미지가 가장 좋은 예시이다. FlexLayout은 Flex 프로퍼티의 변경, 혹은 컨테이너의 크기가 변경될때만 레이아웃이 할당이된다. 그런데 만약, 아이템을 display(.none)을 하거나 다른 방식으로 어떻게든 아이템들의 내용물이 바뀌거나, 레이아웃이 변경되어야는데 새롭게 재할당시키면? 새롭게 재할당된 아이템은, flex 프로퍼티를 변경하지 않는이상 아이템의 레이아웃은 최초에 할당되었을때의 레이아웃을 가지게된다.

이럴때, .markDirty() 메소드를 사용하여 flexbox 트리의 루트로 가서 트리 하위에 다시 새롭게 레이아웃을 계산하도록 하게한다. 이후, .layout()메소드를 사용하거나 setNeedsLayout() 을 사용하여 계산된 레이아웃을 적용시키면 된다.

## .sizeThatFits()
특정한 프레임 사이즈에 맞게 아이템을 레이아웃 시켜주는 메소드이다. 예시는 공식문서에 적힌것처럼

let layoutSize = viewA.flex.sizeThatFits(size: CGSize(width: 200, height: CGFloat.greatestFiniteMagnitude))

이런식으로 적용하면 된다.

## .intrinsicSize()
뷰 자체의 크기를 나타내주는 메소드이다.

# 절대위치 관련 메소드

## .position()
뷰를 컨테이너 안의 위치에 대한 뷰의 위치를 설정하고 싶을때 선언시키는 메소드이다. 파라미터엔 relative, absolute 가 있으며, 기본값으로는 relative 가 설정되있다. 메소드를 사용하려면 파라미터를 absolute를 넣어준 다음 아래에 설명하는 메소드들을 활용하여 위치를 설정해야한다.

## .top(), .bottom(), .left(), .right() ...
이 메소드들은 컨테이너 안의 위치에 대한 뷰의 위치를 조정하는 메소드들이다. 컨테이너를 기준으로 위아래, 좌우, 시작과끝, 전부 를 변경시킬 수 있다. 

모든 메소드들의 대한 내용과 설명은 [공식 GitHub README](https://github.com/layoutBox/FlexLayout#absolute_positioning)에 전부 나와있다.

# 크기 관련 메소드

## .width(), .height(), .size()
뷰의 너비와 높이와 너비,높이 모두를 설정할 수 있는 메소드이다. 파라미터로는 옵셔널 float 타입과 FPercent 타입이 들어간다. float 타입에 음수(negative)값은 들어갈 수 없으며, FPercent 타입을 넣으면 컨테이너의 길이의 퍼센트 만큼 설정되고, nil 을 넣으면 길이를 리셋하게된다.

## .minWidth(), .maxWidth(), .minHeight(), .maxHeight()
.grow(), .shrink() 메소드와 같이 쓰면 좋은 메소드들로, 뷰의 한계 길이를 지정시키는 메소드들이다. .grow(), .shirnk() 를 사용하면 뷰의 길이가 동적으로 바뀌게 되어서 원하는 디자인이 나오지 않게 되는 경우가 있는데, 이럴때 뷰의 한계 길이를 지정시켜놓으면 지정된 길이를 넘어서는 불상사를 방지할 수 있다. 파라미터로는 float 타입과 FPercent가 들어가며, 사용 방식은 .width(), .height(), .size() 메소드들과 동일하다.

## .aspectRatio()
뷰의 비율을 분수의 형태처럼 사용할 수 있게 하는 메소드로, (너비) / (높이) 형태로 사용한다. 흔히 말하는 16:9, 4:3 비율도 간단하게 파라미터로 16/9, 4/3 을 넣어주면 변하게된다. 단, 주의할 점이 있는데 .aspectRatio() 메소드는 .grow() 메소드보다 우선순위가 높기 때문에, 만약 혼용해서 쓰게 될 떄에 주의해야한다.

# 마진 관련 메소드들

## .marginTop(), .marginLeft(), .marginBottom(), marginRight()...
이 메소드들은 같은 뎁스(depth)의 속한 뷰나 상위 뷰에 대한 마진값을 조정하는 메소드들이다. 파라미터엔 float타입과 FPercent 타입이 들어가며, 위아래, 좌우, 시작과 끝, 수직수평 등등 여러 방향의 마진값을 조절할 수 있다.

모든 메소드들의 대한 내용과 설명은 [공식 GitHub README](https://github.com/layoutBox/FlexLayout#margins)에 나와있다.

# 패딩 관련 메소드들 

## .padding(), .paddingTop() .paddingBottom() .paddingLeft() .paddingRight()

컨테이너 내부의 뷰들에게 패딩(offset)을 부여하는 메소드이다. 컨테이너 자체의 패딩은 이 메소드로는 부여할 수 없다. 파라미터로는 float을 타입과 FPercent 타입이 들어가며 또한, UIView.safeAreaInsets, UIView.directionalLayoutMargins 들을 파라미터로도 활용 가능하고, vertical, horizontal 등등 여러 방향으로 적용가능하다.

모든 메소드들의 대한 내용과 설명은 [공식 GitHub README](https://github.com/layoutBox/FlexLayout#paddings)에 나와있다.

# etc

## .backgroundColor()
뷰의 배경 색을 바꾸는 메소드이다. 파라미터로는 UIColor 가 들어가며, 사용법은 UIView.backgroundColor 와 다르게, 파라미터 안에 원하는 색을 선언하는 방식이다.




