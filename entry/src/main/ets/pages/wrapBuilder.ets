/**
 *  封装全局@Builder
 *  在一个struct内使用了多个全局@Builder函数，
 *  来实现UI的不同效果
 * 多个全局@Builder函数会使代码维护起来非常困难，
 * 并且页面不整洁。
 * 开发者可以使用wrapBuilder来封装全局@Builder
 *
 * 限制条件
 * 1、wrapBuilder方法只能传入全局@Builder方法
 * 2、wrapBuilder方法返回的WrappedBuilder对象的
 *   builder属性方法只能在struct内部使用
 */


/**
 *
 * @param value
 * @param size
 * @Builder方法赋值给变量或者数组后，赋值的变量或者数组在UI方法中无法使用
 *
 * @Builder
 * function builderElement(){}
 *
 * let builderArr:Function[] = [builderElement]
 *
 * @Builder
 * function testBuilder(){
 *    ForEach(builderArr,(item:Function)=>{
 *      item();
 *    })
 * }
 * 为了解决这一问题，引入wrapBuilder作为全局@Builder封装函数，wrapBuilder的参数
 * 返回WrappedBuilder对象，实现全局@Builder可以进行赋值和传递
 *
 */


@Builder
function MyBuilder(value: string, size: number) {
  Text(value)
    .fontColor(Color.Blue)
    .fontSize(size)
}

@Builder
function YourBuilder(value: string, size: number) {
  Text(value)
    .fontSize(size)
    .fontColor(Color.Pink)
}


let globalBuilder: WrappedBuilder<[string, number]> = wrapBuilder(MyBuilder);


const builderArr: WrappedBuilder<[string, number]>[] = [wrapBuilder(MyBuilder), wrapBuilder(YourBuilder)]

@Entry
@Component
struct Index {
  @State message: string = '+++Hello World+++'

  @Builder
  testBuilder() {
    ForEach(builderArr, (item:
      WrappedBuilder<[string, number]>) => {
      item.builder('hello', 30)
    })
  }

  build() {
    Row() {
      Column() {
        globalBuilder.builder(this.message, 40)
        this.testBuilder()
      }
      .width('100%')
    }.height('100%')
  }
}

