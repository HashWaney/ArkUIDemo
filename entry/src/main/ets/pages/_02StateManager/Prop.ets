/**
 * @Prop装饰的变量可以和父组件建立单向的同步关系，
 * @Prop装饰的变量是可变的，
 * 但是变化不会同步回其父组件
 */

// 自定义的子组件
@Component
struct CountDownComponent {
  // 普通的变量如果没有用到咱们的状态管理

  // @State
  // @Prop 将父组件中的数据进行传递给子组件
  // 子组件内部想将父组件传递的值修改之后传给父组件
  // 是无法做到触发UI渲染
  @Link count: number ; // 装饰器修饰的倒计时变量
  costOfOneAttempt: number = 1;

  // constructor(count:number) {
  //   this.count =count
  // }

  build() {
    Column() {
      Divider()
        .backgroundColor(Color.Red)
        .borderWidth(2)
      Text('子组件内容')
        .fontSize(30)
      if (this.count > 0) { // 10>0
        Text(`You have ${this.count} Nuggets left`)
          .fontSize(30)
      } else {
        Text('Game over!')
          .fontSize(30)
      }
      // @Prop装饰的变量不会同步给父组件
      Button(`Try again`).onClick(() => {
        this.count -= this.costOfOneAttempt;
      })
      Divider()
        .backgroundColor(Color.Red)
        .borderWidth(2)
    }
  }
}

@Entry
@Component
struct ParentComponent { //
  // 代理对象 以及观察者模式
   @State countDownStartValue: number = 10;

  build() {
    Column() {
      Text('父组件')
      Divider()
        .backgroundColor(Color.Pink)
        .borderWidth(2)
      Text(`Grant ${this.countDownStartValue} nuggets to play.`)
      // 父组件的数据源的修改会同步给子组件
      Button(`+1 - Nuggets in New Game`).onClick(() => {
        this.countDownStartValue += 1;
      })
      // 父组件的修改会同步给子组件
      Button(`-1  - Nuggets in New Game`).onClick(() => {
        this.countDownStartValue -= 1;
      })

      // 从父组件===》将count =10 --》传递给子组件===CountDownCompent
      CountDownComponent(
        // count:this.countDownStartValue
        { count: this.countDownStartValue, costOfOneAttempt: 2 }
      )
        .margin({ top: 20, bottom: 20 })

      Divider()
        .backgroundColor(Color.Green)
        .borderWidth(2)
    }
  }
}