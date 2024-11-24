/**
 * 当使用@Builder做引用数据传递时候，会考虑组件之间的父子关系
 * 使用了bind(this)之后，组件的父子关系和状态管理的父子关系并不一致？？？？
 * 为了解决组件的父子关系和状态管理的父子关系保持一致的问题，
 * 使用@LocalBuilder装饰器，确定组件的父子关系和状态管理的父子关系
 */


// 使用场景：
// 组件Parent内的@LocalBuilder方法在build函数内调用，按键值对写法传值
// 当点击Click me时，@LocalBuilder内的Text文本内容会随着状态变量内容的改变而改变
//@LocalBuilder和@Builder区别说明
// 函数componentBuilder被@Builder修饰时，显示效果是 “Child”，
// 函数componentBuilder被@LocalBuilder修饰时，显示效果是“Parent”。

class ReferenceType {
  paramString: string = '';
}

@Entry
@Component
struct Parent {
  label: string = 'Parent'
  // 状态变量
  @State variableValue: string = 'HelloWorld'

  @Builder
  componentBuilder() {
    Text(`${this.label}`)
      .fontSize(30)
      .fontColor(Color.Blue)
  }

  @LocalBuilder
  componentBuilder1() {
    Text(`${this.label}`)
      .fontSize(30) .fontColor(Color.Red)
  }

  @LocalBuilder
  citeLocalBuilder(params: ReferenceType) {
    Row() {
      Text(`UseState is  ${params.paramString}`)
    }
  }

  build() {
    Column() {
      this.citeLocalBuilder({ paramString: this.variableValue })
      Button('Click me').onClick(() => {
        this.variableValue = 'Hi I am OK '
      })
      Child({ customBuilderParam: this.componentBuilder })
      Child({ customBuilderParam: this.componentBuilder1 })
    }
  }
}

@Component
struct Child {
  label: string = 'Child'
  @BuilderParam customBuilderParam: () => void;

  build() {
    Column() {
      this.customBuilderParam()
    }
  }
}