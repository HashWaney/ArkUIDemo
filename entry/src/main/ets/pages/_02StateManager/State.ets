/**
 * 组件内状态 @State
 * 一旦变量拥有了状态属性，就可以触发其直接绑定UI组件的刷新。当状态改变时候，UI会发生对应的渲染改变。
 *
 *特点：
 * 1、私有的，只能从组件内部访问
 * 2、声明时候必须指定其类型和本地初始化，初始化也可选择使用命名参数机制从父组件完成初始化
 * 3、装饰的变量与子组件中的@Prop装饰变量之间建立单向数据同步，与@Link、@ObjectLink装饰变量之间建立双向数据同步
 * 4、@State装饰的变量生命周期与其所属自定义组件的生命周期相同。
 */

// 状态变量只能影响其直接绑定的UI组件的刷新
class Parent {
  son: string = '000'
}

class Parent2{
    son:Son = new Son('Son111')
}

class Son {
  son: string = '000Son'

  constructor(son: string) {
    this.son = son
  }
}


@Entry
@Component
struct Test {
  @State son: string = '111'
  @State parent: Parent = new Parent();

  @State sonC:Son = new Son('Son222')
  @State parent2:Parent2 =new Parent2()

  aboutToAppear(): void {
    this.parent.son = this.son
    this.parent2.son =this.sonC
  }

  build() {
    Column() {
      Text(`${this.son}`)
      Text(`${this.parent.son}`)
      Text(`sonC ${this.sonC.son}`)
      Text(`Parent2 ${this.parent2.son.son}`)
      Button('Click me')
        .onClick(() => {
          this.parent.son = '222'
          this.parent2.son.son ='SonC333'
          // this.parent2.son.son ===>this.sonC.son 
        })
    }

  }
}