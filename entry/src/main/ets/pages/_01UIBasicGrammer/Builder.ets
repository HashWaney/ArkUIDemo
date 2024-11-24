/**
 *
 * ArkUI 提供一种轻量的UI复用机制@Builder。该自定义组件内部UI结构固定，
 * 仅仅与调用方进行数据传递，开发者将重复使用的UI元素抽象成一个方法，在build方法中调用
 *
 * 将@Builder装饰的函数称为自定义构建函数
 *
 * 1、@Builder通过按引用传递的方式传入参数，才会触发动态渲染UI，并且参数只能是一个
 * 2、@Builder如果传入的参数是两个或两个以上，不会触发动态渲染UI
 * 3、@Builder传入的参数中同时包含按值传递和按引用传递两种方式，不会触发动态渲染UI
 * 4、@Builder的参数必须按照对象字面量的形式，将所需要的属性一一传入，才会触发动态渲染UI
 */

class Tmp {
  paramA: string = ''
}

@Builder function overBuilder(params: Tmp) {
  Row() {
    Text(`UserStateVarByReference :${params.paramA}`)
  }
}


@Entry
@Component
struct Parent {
  @State label: string = 'hello'

  build() {
    Column() {
      //在父组件中调用overBuilder组件时
      // 把this.label通过引用传递的方式传给overBuilder组件
      overBuilder({ paramA: this.label })
      Button('Click me').onClick(()=>{
        this.label ='ArkUI'
      })


    }
  }
}

@Component
struct Child{
  label:string ='Child'
  @BuilderParam customBuilderParam :()=>void;
  build() {
    Column(){
      this.customBuilderParam
    }
  }
}