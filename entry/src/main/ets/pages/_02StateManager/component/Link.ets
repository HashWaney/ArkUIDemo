/**
 * @Link的工作原理
 * 1、父组件的数据传递给子组件：
 *  父组件将一个状态属性绑定到子组件的@Link装饰器声明的属性上
 *  初始数据从父组件传递到子组件
 * 2、子组件数据更新传递回父组件
 *   子组件可以直接修改通过@Link声明的属性
 *   修改后的数据会自动同步到父组件对应的状态
 *
 * 注意事项
 * 1、不要直接修改父组件的属性
 *  使用@Link可以避免子组件直接操作父组件状态，而是通过框架提供的绑定机制来更新父组件状态
 * 2、性能和复杂性：
 *  双向绑定适合在父子组件间需要频繁交互时候使用，但是过度依赖可能导致数据流复杂
 */
class GreenButtonState {
  width: number = 0;

  constructor(width: number) {
    this.width = width;
  }
}
// 1、通过 git方式将自己的一些学习代码管理起来，防止更换设备之后，代码丢失
// 2、有对应的提交记录===》学习的成长过程
// 3、git版本管理工具---gitlab
// 4、为了协同开发以及开发权限管理==保证公司的资产q
/// git remote add origin https://github.com/HashWaney/ArkUIDemo.git


@Component
struct GreenButton {
  @Link greenButtonState: GreenButtonState;

  build() {
    Button('Green Button')
      .width(this.greenButtonState.width)
      .height(40)
      .backgroundColor('#64bb5c')
      .fontColor('#FFFFFF，90%')
      .onClick(() => {
        if (this.greenButtonState.width < 700) {
          // 更新class的属性，变化可以被观察到同步回父组件
          this.greenButtonState.width += 60;
        } else {
          // 更新class，变化可以被观察到同步回父组件
          this.greenButtonState = new GreenButtonState(180);
        }
      })
  }
}

@Component
struct YellowButton {
  @Link yellowButtonState: number;

  build() {
    Button('Yellow Button')
      .width(this.yellowButtonState)
      .height(40)
      .backgroundColor('#f7ce00')
      .fontColor('#FFFFFF，90%')
      .onClick(() => {
        // 子组件的简单类型可以同步回父组件
        this.yellowButtonState += 40.0;
      })
  }
}

@Entry
@Component
struct ShufflingContainer {
  @State greenButtonState: GreenButtonState = new GreenButtonState(180);
  @State yellowButtonProp: number = 180;

  build() {
    Column() {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
        // 简单类型从父组件@State向子组件@Link数据同步
        Button('Parent View: Set yellowButton')
          .width(312)
          .height(40)
          .margin(12)
          .fontColor('#FFFFFF，90%')
          .onClick(() => {
            this.yellowButtonProp = (this.yellowButtonProp < 700) ? this.yellowButtonProp + 40 : 100;
          })
        // class类型从父组件@State向子组件@Link数据同步
        Button('Parent View: Set GreenButton')
          .width(312)
          .height(40)
          .margin(12)
          .fontColor('#FFFFFF，90%')
          .onClick(() => {
            this.greenButtonState.width = (this.greenButtonState.width < 700) ? this.greenButtonState.width + 100 : 100;
          })
        // class类型初始化@Link
        GreenButton({ greenButtonState: $greenButtonState }).margin(12)
        // 简单类型初始化@Link
        YellowButton({ yellowButtonState: $yellowButtonProp }).margin(12)
      }
    }
  }
}