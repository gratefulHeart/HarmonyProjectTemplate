export class MyScrollModifier implements AttributeModifier<ScrollAttribute> {
  applyNormalAttribute(instance: ScrollAttribute): void {
    // instance为Scroll的属性对象，设置正常状态下属性值
    instance.scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .layoutWeight(1)
      .align(Alignment.TopStart)
  }
}

export class SourceTextModifier implements AttributeModifier<TextAttribute> {
  applyNormalAttribute(instance: TextAttribute): void {
    instance.fontSize($r('sys.float.Body_S'))
      .fontWeight(FontWeight.Regular)
      .fontColor($r('sys.color.font_tertiary'))
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .wordBreak(WordBreak.BREAK_ALL)
  }
}

export class TopRowModifier implements AttributeModifier<RowAttribute> {
  applyNormalAttribute(instance: RowAttribute): void {
    instance.width('100%')
      .height($r('app.float.vp_56'))
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: $r('app.float.vp_16'), right: $r('app.float.vp_16') })
  }
}