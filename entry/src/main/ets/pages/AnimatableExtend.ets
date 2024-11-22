/**
 * AnimatableExtend装饰器用于自定义可动画属性，
 * 在这个属性方法中修改组件不可动画的属性
 * 在动画执行过程中，通过逐帧回调函数修改不可动画属性值，
 * 让不可动画属性也能实现动画效果，
 * 也可以通过逐帧回调函数修改可动画属性的值，
 * 实现逐帧布局的效果
 *
 * - 可动画属性
 *
 * 如果一个属性方法在animation属性前调用，改变这个属性的值可以使animation属性
 * 的动画效果生效，这个属性称为可动画属性，比如height、width、backgroundColor、
 * translate属性，和Text组件的fontSize属性
 *
 * - 不可动画属性
 * 如果一个属性方法在animation属性前调用，改变这个属性不能使得animation属性的动画效果生效，这个属性也称为不可动画属性
 * 比如Polyline组件的points属性等
 *
 *
 *
 */
@AnimatableExtend(Text)
function animatableWidth(params: number) {
  .width(params)
}

@Entry
@Component
struct AnimatablePropertyExample {
  @State textWidth: number = 100;

  build() {
    Column() {
      Text('AnimatableProperty')
        .animatableWidth(this.textWidth)
        .fontSize(36)
        // curve ：曲线
        .animation({ duration: 2000, curve:Curve.Smooth })
      Button('Play')
        .fontSize(30)
        .onClick(() => {
          this.textWidth = this.textWidth == 100 ? 200 : 100
        }).width("100%")

        .padding(10)
    }

  }
}
