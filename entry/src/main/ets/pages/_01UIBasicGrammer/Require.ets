/**
 *
 * @Require 是校验@Prop、@State、@Provide、@BuilderParam和普通
 * 变量（无状态装饰器修饰的变量）是否需要构造传承的一个装饰器
 *
 * 当@Require装饰器和@Prop、@State、@Provide、@BuilderParam、普通变量
 * （无状态装饰器修饰的变量）结合使用时，在构造该自定义组件时候，
 * @Prop、@State、@Provide、@BuilderParam和普通变量（无状态装饰器修饰的变量）
 *必须在构造时候传参
 *
 * @Require装饰器仅仅用于装饰struct内的@Prop、@State、@Provide、@BuilderParam
 * 和普通变量
 *
 * // 使用场景
 * 当Child组件内使用@Require装饰器和@Prop、@State、@Provide、@BuilderParam和普通变量结合使用、
 * 父组件Index在构造Child时候必须传参、否则编译不通过
 *
 *
 */
@Entry
@Component
struct AccessRestrictions {
  @Builder
  buildTest() {
    Text("Parent builder")
      .fontColor(Color.Pink)
      .fontSize(100)
  }

  build() {
    Column() {
      ComponentsChild({
        state_value: "Hello",
        prop_value: "Hello",
        provide_value: "Hello",
        builder_value: this.buildTest,
        regular_value: "Hello"
      })
    }.height('100%')
    .width('100%')
  }
}

@Component
struct ComponentsChild {
  @Builder
  buildTest() {
    Text("Child builder")
      .fontColor(Color.Red)
      .fontSize(100)
  }

  @State private state_value: string = "Hello";
  @Prop private prop_value: string = "Hello";
  @Provide private provide_value: string = "Hello";
  @Require @BuilderParam private builder_value: () => void = this.buildTest;
  private regular_value: string = "Hello";

  build() {
    Column() {
      Text("HelloWorld")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      this.builder_value()

    }
  }
}