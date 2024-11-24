// 入口装饰器 ==>
const  TAG ="State"
@Entry
@Component
struct States { // 结构体 === 》包装系统组件   // 组件装饰器 ==> 声明自定义组件
  // 代理对象 观察这个状态变量
  @State value:string ='Hello World'
  // if(debug==true) {
  //   console.debug()
  // }
  // console.info()
  // console.error() // 传日志的日志方式传给后台
  myClickHandler():void{
    console.log(TAG,"click event ")
    // 如果这个状态变量 发生变化 =
    this.value ='Hello ArkUI'
  }

  build() {
    // 具体执行如何去组装
    // 系统组件 === 》1、普通组件（Text Button Image Video） 2、容器组件
    Column() {
      // 就会通知这个Text组件重新渲染
      Text(`当前显示的是${this.value}`)
        .fontSize(40)
      Button('Click Me')
        .fontSize(30)
        .onClick(this.myClickHandler.bind(this))

    }

  }
}