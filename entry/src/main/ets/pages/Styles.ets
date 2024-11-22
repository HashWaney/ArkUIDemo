/**
 *  如果每个组件的样式都需要单独设置，在开发过程中会出现大量代码在进行重复样式设置，
 *  虽然可以复制粘贴，但是为了代码简洁性和后续方便维护，推出了提炼公共样式进行复用的装饰器@Styles
 *
 * @Styles装饰器可以将多条样式设置提炼成一个方法，直接在组件声明的位置调用，通过@Styles装饰器可以快速定义并
 * 复用自定义样式
 *
 *
 * 使用说明
 * 1、仅仅支持通用属性和通用事件
 * 2、不支持参数
 *
 * 3、可以定义在组件内或全局，在全局定义时需在方法名前面
 *    添加function关键字，组件内定义时
 *    不需要添加function关键字
 * 4、只能在当前文件内使用，不支持export
 *    想实现export功能，推荐使用AttributeModifier
 * // 全局
 * @Styles function functionName(){....}
 *
 * // 在组件内
 * @Component
 * struct Styles{
 * @Styles style(){
 *      .height(100)
 *    }
 *
 * }
 *
 * 5、如果要实现跨文件操作的功能，可以参考使用动态属性设置？
 *
 * // index.ets
 * import {MyButtonModifier} from './setAttribute'
 *
 * @Entry
 * @Component
 * struct attributeDemo{
 *
 * @State modifier:MyButtonModifier = new MyButtonModifier()
 *
 *    build(){
 *      Row(){
 *        Column(){
 *          Button('Button')
 *          .attributeModifier(this.modifier)
 *          .onClick(()=>{
 *            this.modifier.isDark = !this.modifier.isDark
 *          })
 *        }.width('100%')
 *      }.height('100%')
 *  }
 * }
 *
 * //setAttribute.ets
 * export class MyButtonModifier implements AttributeModifier<ButtonAttribute>{
 *      isDark:boolean = false
 *      applyNormalAttribute(instance:ButtonAttribute):void{
 *          if(this.isDark){
 *             instance.backgroundColor(Color.Black)
 *          }else{
 *              instance.backgroundColor(Color.Red)
 *          }
 *      }
 * }
 *
 */
/**
 * 定义在组件内的@Styles可以通过this访问组件的常量和状态变量，
 * 并可以在@Styles里面通过事件来改变状态变量的值
 *
 * 组件内的@Styles的优先级高于全局@Styles
 * 框架优先找当前组件内的@Styles，如果找不到，则会全局查找
 */
// 定义在全局的@Styles封装的样式
@Styles
function globalStyle() {
  .width(150)
  .height(100)
  .backgroundColor(Color.Pink)

}

@Entry
@Component
struct FancyUse {
  @State heightValue: number = 100

  //定义在组件内部的@Styles封装的样式
  @Styles
  fancy() {
    .height(this.heightValue)
    .backgroundColor(Color.Yellow)
    .onClick(() => {
      this.heightValue = 200
    })
  }

  build() {
    Column({ space: 10 }) {
      // 使用全局的@Styles封装的样式
      Text('FancyA')
        .globalStyle()
        .fontSize(20)

      // 使用组件内的@Styles封装的样式
      Text('FancyB')
        .fancy()
        .fontSize(40)
    }
  }
}