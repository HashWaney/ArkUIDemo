/**
 * 之前的装饰器仅仅能观察到第一层的变化
 * 但在实际应用开发中，应用会根据开发需要，封装自己的数据模型
 * 对于多层嵌套的情况，比如二维数组，或者数组项class，
 * 或class的属性是class，第二层的属性变化是无法观察到的
 * 这就引出了@Observed/@ObjectLink装饰器
 *
 * 使用@ObjectLink和@Observed类装饰器用于在涉及嵌套对象或数组场景中进行双向数据同步
 * - 被@Observed装饰的类，可以被观察到属性的变化
 * - 子组件中@ObjectLink装饰器装饰的状态变量用于接收@Observed装饰的类的实例
 *https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-observed-and-objectlink-V5
 *
 */
class ChildA {
  public num: number;

  constructor(num: number) {
    this.num = num
  }
}

// Parent 被@Observed装饰，其成员变量的赋值变化是可以被观察到的，但对于Child，没有被@Observed装饰，其属性的修改不能被观察到。
/**
 * @ObjectLink parent:Parent
 * // 赋值变化可以被观察到
 * this.parent.child = new Child(5)
 * this.parent.count = 5
 * // Child没有被@Observed装饰，其属性的变化观察不到
 * this.parent.child.num =45
 */
@Observed
class ParentA {
  public child: ChildA
  public count: number;

  constructor(child: ChildA, count: number) {
    this.child = child;
    this.count = count
  }
}

@Observed
class DateClass extends Date {
  constructor(args: number | string) {
    super(args)
  }
}

@Observed
class NewData {
  public data: DateClass

  constructor(data: DateClass) {
    this.data = data
  }
}

@Component
struct Child {
  label: string = 'date'
  @ObjectLink data: DateClass

  build() {
    Column() {
      Button('child add 1 day')
        .onClick(() => {
          this.data.setDate(this.data.getDate() + 1)
        }).fontSize(30)
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2024-12-22'),
        selected: this.data
      })
    }
  }
}

@Entry
@Component
struct Parent {
  @State newData: NewData = new NewData(new DateClass('2023-1-1'))

  build() {
    Column() {
      Child({ label: 'date', data: this.newData.data })

      Button('parent update date')
        .margin({top:20})
        .fontSize(30)
        .onClick(() => {
          this.newData.data = new DateClass('2024-01-28')

        })

      Button('parent change date')
        .fontSize(30)
        .margin({top:20})
        .onClick(() => {
        this.newData = new NewData(new DateClass('2024-01-04'))
      })
    }

  }
}