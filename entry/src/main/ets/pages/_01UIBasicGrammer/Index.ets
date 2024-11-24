
@Entry
@Component
struct Index { // 自定义组件

  @State message: string = 'Hello World';

  build() {
    Column() { // 线性容器 纵向布局
      // RelativeContainer(){
      //   // 多级嵌套
      //
      // }
      // 主轴
      Text("Hello")// 组件===》类
        .fontSize(100)
        .fontColor(Color.Gray)
      Text("content")
        .fontSize(100)
        .fontColor(Color.Green)
      Text("U2")
        .fontSize(100)
        .fontColor("#ffbf137d")

      // class Text{
      //    Text(){
      //    }
      //    Text(String content){
      //    }
      // }
    }
    .height('100%')
    .width('100%')
  }
}

