/**
 * @Prop装饰的变量可以和父组件建立单向的同步关系，@Prop装饰的变量是可变的，
 * 但是变化不会同步回其父组件
 */

@Component
struct CountDownComponent {
  @Prop count: number = 0;
  costOfOneAttempt: number = 1;

  build() {
    Column() {
      Divider()
        .backgroundColor(Color.Red)
        .borderWidth(2)
      Text('子组件内容')
      if (this.count > 0) {
        Text(`You have ${this.count} Nuggets left`)
      } else {
        Text('Game over!')
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
struct ParentComponent {
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

      CountDownComponent({ count: this.countDownStartValue, costOfOneAttempt: 2 })
        .margin({top:20,bottom:20})

      Divider()
        .backgroundColor(Color.Green)
        .borderWidth(2)
    }
  }
}