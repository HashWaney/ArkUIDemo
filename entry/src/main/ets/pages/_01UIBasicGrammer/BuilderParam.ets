/**
 * 当创建了自定义组件，并想对该组件添加特定的功能时，
 * 例如在自定义组件中添加一个点击跳转操作，
 * 如果直接在组件内嵌入事件方法，将会导致所有引入该自定义组件的地方钧增加了该功能，
 *
 * 为了解决该问题，ArkUI引入了@BuilderParams装饰器，
 *
 * 使用@BuilderParam用来装饰指向@Builder方法的变量，
 *
 * 初始化@BuilderParam装饰的方法
 *
 * @BuilderParam装饰的方法只能被自定义构建函数（@Builder装饰的方法）初始化
 *
 */

// 全局自定义构建函数
@Builder
function overBuilder($$: Tmp) {
  Text($$.label)
    .width(400)
    .height(50)
    .backgroundColor(Color.Red)
}


class Tmp {
  label: string = ''
}

@Component
struct Child {
  label:string ='Child ss'
  @Builder
  doNothingBuilder() {
  };

  // 使用自定义组件的自定义构建函数初始化@BuilderParam
  @BuilderParam customBuilderParams: () => void = this.doNothingBuilder;
  // 使用全局自定义构建函数初始化@BuilderParams
  @BuilderParam customOverBuilderParams: ($$:Tmp) => void = overBuilder;

  build() {
    Column() {
      this.customBuilderParams()
      this.customOverBuilderParams({label:'Builder Label'})
    }
  }
}

@Entry
@Component
struct Parent {
  // 使用父组件@Builder装饰的方法--->componentBuilder初始化子组件@BuilderParam -->customBuilderParams
  label:string ='Parent '
  @Builder
  componentBuilder() { // 父组件构建的componentBuilder  ==> 传递给customBuilderParams
    Text(`${this.label}`)
  }

  build() {
    Column() {
      // 构造方法进行初始化
      Child({
        // customBuilderParams: this.componentBuilder,
        // 箭头函数的this指向的时宿主对象，所有label时“Parent Page"
        customBuilderParams:():void =>{this.componentBuilder()},
        customOverBuilderParams:overBuilder,

      })
    }
  }
}