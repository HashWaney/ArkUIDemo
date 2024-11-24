/**
 *
 * 上一个章节中介绍的装饰器仅仅能在页面内，即一个组件树上共享状态变量
 * ，如果要实现应用级别，或多个页面的状态数据共享，就需要用到应用级别的状态管理概念
 * - LocalStorage：页面级别UI状态存储，通用用于UIAbility内、
 *                页面间的状态共享
 * - AppStorage：特殊的单例LocalStorage对象，由UI框架在应用程序启动时候创建，
 *              为应用程序UI状态属性提供中央存储
 * - PersistentStorage：持久化存储UI状态，通常和AppStorage配合使用，
 *     选择AppStorage存储的数据写入磁盘，
 *    以确保这些属性在应用程序重新启动时的值与应用程序关闭时候的值相同。
 * - Environment：应用程序运行的设备的环境参数，环境参数会同步到AppStorage中，
 *            可以和AppStorage搭配使用
 *
 *
 *  LocalStorage是页面级的UI状态存储，
 *  通过@Entry装饰器接收的参数可以在页面内
 * 共享同一个LocalStorage实例，LocalStorage
 * 支持UIAbility实例内多个页面间状态共享
 *
 * LocalStorage是ArkTS为构建页面级别状态变量提供
 * 存储的内存内的”数据库“
 *
 * - 应用程序可以创建多个LocalStorage实例，LocalStorage实例可以在页面内共享，
 * 也可以通过GetShared接口、实现跨页面、UIAbility实例内共享
 *
 * - 组件树的根节点，即被@Entry装饰的@Component，可以被分配一个LocalStorage实例，
 * 此组件的所有子组件实例将自动获得对该LocalStorage实例的访问权限
 *
 * - 被@Component装饰的组件最多可以访问一个LocalStorage
 *
 */