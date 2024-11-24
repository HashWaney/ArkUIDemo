/**
 * 在@Styles的基础上，提供@Extend，用于扩展原生组件样式
 *
 *
 * 1、只能在当前文件内使用，不支持export
 * 如果要实现export功能，推荐使用AttributeModifier
 *
 * 2、和@Styles不同，@Extend仅仅支持全局定义，不支持在组件内部定义
 *
 * 3、@Extend支持封装指定组件的私有属性，私有事件和自身定义的全局方法
 *  // @Extend(Text)可以支持Text的私有属性fontColor
 * @Extend(Text) function fancy(){
 *      .fontColor(Color.Red)
 *  }
 * // superFancyText可以调用预定义的fancy
 * @Extend(Text) function superFancyText(size:number){
 *      .fontSize(size)
 *      .fancy()
 * }
 *
 * 4、@Extend装饰的方法支持参数，开发者可以在调用时传递参数，调用遵循TS方法传值调用
 *
 * @Extend(Text) function fancy(fontSize:number){
 *        .fontColor(Color.Red)
 *        .fontSize(fontSize)
 * }
 * @Entry
 * @Component
 * struct FancyUse{
 *    build(){
 *        Row({space:10}){
 *            Text('Fancy')
 *              .fancy(16)
 *            Text('Fancy')
 *              .fancy(24)
 *        }
 *    }
 * }
 *
 *
 *
 * 5、@Extend装饰的方法的参数可以为function，作为Event事件的句柄
 *
 * @Extend(Text) function click(onClick:()=>void){
 *      .backgroundColor(Color.Blue)
 *      .onClick(onClick)
 *  }
 * @Entry
 * @Component
 * struct FancyUse{
 * @State label:string ='Hello'
 *
 *    onClickHandler(){
 *      this.label ='Hello ArkUI'
 *   }
 *
 *    build(){
 *      Row({space:10}){
 *         Text(`${this.label}`)
 *          .click(()=>{this.onClickHandler()})
 *      }
 *    }
 * }
 *
 * 6、@Extend的参数可以为状态变量，当状态变量改变时候，UI可以正常地被渲染刷新
 *
 * @Extend(Text) function fancy(fontSize:number){
 *    .fontColor(Color.Red)
 *    .fontSize(fontSize)
 * }
 *
 * @Entry
 * @Component
 * struct FancyUse{
 * @State fontSizeValue:number =20
 *    build(){
 *      Row({space:20}){
 *         Text('Fancy')
 *          .fancy(this.fontSizeValue)
 *           .onClick(()=>{
 *            this.fontSizeValue = 30
 *          })
 *      }
 *   }
 * }
 */

@Extend(Text)
function fancyText(weightValue: number, color: Color) {
  .fontSize(30)
  .fontStyle(FontStyle.Italic)
  .fontWeight(weightValue)
  .backgroundColor(color)
}


@Entry
@Component
struct FancyUse {
  @State label: string = 'Hello'

  build() {
    Row({ space: 10 }) {
      Text(`${this.label}`)
        .fontStyle(FontStyle.Italic)
        .fontWeight(100)
        .backgroundColor(Color.Red)
      Text(`${this.label}`)
        .fontStyle(FontStyle.Italic)
        .fontWeight(200)
        .backgroundColor(Color.Pink)
      Text(`${this.label}`)
        .fontStyle(FontStyle.Italic)
        .fontWeight(300)
        .backgroundColor(Color.Orange)

      Text(`${this.label}`)
        .fancyText(100,Color.Green)
      Text(`${this.label}`)
        .fancyText(200,Color.Brown)
      Text(`${this.label}`)
        .fancyText(300,Color.Grey)
    }.width('100%')
    .height('100%')

  }
}