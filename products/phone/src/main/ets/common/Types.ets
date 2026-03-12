/**
 * 服务卡片-跳转模型
 */
@ObservedV2
export class FormCardRouter {
  @Trace id: number = 0;
  @Trace pageUrl: string = '';
  @Trace newsId: string = '';
  @Trace newsType: number = 0;
}