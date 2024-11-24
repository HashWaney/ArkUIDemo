/**
 * @Prop装饰的变量可以和父组件建立单向的同步关系，
 * @Prop装饰的变量是可变的，
 * 但是变化不会同步回其父组件
 *
 * 工作原理：
 * @Prop的核心机制基于属性传递（Props)
 * 1、父组件传递数据：父组件在使用子组件时候，通过标签属性将数据传递给子组件
 * 2、子组件通过@Prop接收数据：在子组件中，使用@Prop装饰器声明要接收的属性，@Prop装饰器，表示这个字段是一个属性（来自父组件的数据），框架自动将父组件传递的值绑定到这个字段上。
 * 3、数据绑定和更新：父组件的数据通过@Prop绑定到子组件。一旦父组件更新了绑定的数据，子组件会自动感知并更新相应的属性。
 *
 *
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