/**
 *
 * @Styles 仅仅应用于静态页面的样式复用，stateStyles可以依据组件的内部状态的不同
 * 快速设置不同的样式。
 * 1、仅仅支持通用属性
 * UI内部状态：
 * 1、focused:  获取焦点
 * 2、normal:   正常态
 * 3、pressed:  按压态
 * 4、disabled: 不可用态
 * 5、selected: 选中态
 * 类似于css伪类
 */
// 基础场景： Button1处于第一个组件，Button2处于第二个组件，
// 按压时候显示为pressed态指定的黑色
// 使用Tab键走焦，先是Button1获焦并显示focus态指定的粉色，
// 当Button2获焦的时候，Button2显示为focus态指定的粉色
// Button1失去焦点显示normal态指定的蓝色

@Entry
@Component
struct StateStyleSample {
  build() {
    Column() {
      Button('Button10  ')
        .stateStyles({
          focused: {
            .backgroundColor(Color.Pink)
          },
          pressed: {
            .backgroundColor(Color.Black)
          }
        ,
          normal: {
            .backgroundColor(Color.Blue)
          }
        }).margin(20)
      Button('Button20')
        .stateStyles({
          focused: {
            .backgroundColor(Color.Pink)

          },
          pressed: {
            .backgroundColor(Color.Black)
          },
          normal: {
            .backgroundColor(Color.Blue)
          }
        }).margin(20)
      stateStyleUse()
      CommonWithStateStyles()
    }
  }
}

// @Styles 和stateStyles联合使用

@Component
struct stateStyleUse {
  @Styles
  normalStyle(){
    .backgroundColor(Color.Gray)
  }

  @Styles
  pressedStyle(){
    .backgroundColor(Color.Red)
  }

  build() {
    Column() {
      Text('Text1')
        .fontSize(50)
        .fontColor(Color.White)
        .stateStyles({
          normal: this.normalStyle,
          pressed: this.pressedStyle
        })
    }
  }
}

// 在 stateStyles里面使用常规变量和状态变量
// stateStyles可以通过this绑定组件内的常规变量和状态变量

@Component
struct CommonWithStateStyles {
  // 状态变量
  @State focusedColor: Color = Color.Red
  normalColor: Color = Color.Green
  @State pressedColor:Color =this.normalColor

  build() {
    Column() {
      Button('ClickMe')
        .height(100)
        .width(100)
        .stateStyles({
          normal: {
            .backgroundColor(this.normalColor)
          }
        ,
          focused: {
            .backgroundColor(this.focusedColor)
          },
          pressed:{
            .backgroundColor(this.pressedColor)
          }

        })
        .onClick(() => {
          this.focusedColor = Color.Pink
          this.pressedColor =Color.Orange
        })

    }

  }
}
