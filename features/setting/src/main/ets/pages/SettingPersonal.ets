import { FunctionalButton, functionalButtonComponentManager } from '@kit.ScenarioFusionKit';
import { CommonConstants, GridRowColSetting } from 'lib_common';
import { NavHeaderBar } from 'lib_widget'
import { SettingPersonalVM } from '../viewmodels/SettingPersonalVM';

@Builder
export function SettingPersonalBuilder() {
  SettingPersonal()
}

let body: string[] = [];
let purpose: string[] = [];

@ComponentV2
export struct CustomButton {
  @Local isOn: boolean = false  // 独立状态存储
  @Param class: string = ''
  @Param label: string = ''    // 按钮文本
  @Param private themeColor: Resource = $r('app.color.app_theme')  // 主题色
  @Param private backColor: Resource = $r('sys.color.comp_background_tertiary')
  @Param private foreColor: string = 'rgba(0, 0, 0, 0.9)'

  build() {
    Button(this.label)
      .width(80)
      .height(28)
      .fontSize($r('sys.float.Body_S'))
      .borderRadius(14)
      .fontColor(this.isOn ? Color.White : this.foreColor)
      .backgroundColor(this.isOn ? this.themeColor : this.backColor)
      .onClick(() => {
        this.isOn = !this.isOn  // 状态自动切换
        if (this.isOn) {
          if (this.class === 'body') {
            body.push(this.label)
          }
          else {
            purpose.push(this.label)
          }
        }
        else {
          if (this.class === 'body') {
            const index = body.findIndex(item => item === this.label);
            body.splice(index, 1);
          }
          else {
            const index = purpose.findIndex(item => item === this.label);
            purpose.splice(index, 1);
          }
        }
      })
  }
}

@ComponentV2
struct SettingPersonal {
  @Local vm: SettingPersonalVM = new SettingPersonalVM();
  private genderPicker: string[] = ['男', '女'];
  private ageOptions: number[] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,
    26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,
    51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,
    76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100];  // 年龄选项数组
  private agePicker: string[] = this.ageOptions.map(item => item.toString());
  selectedGender: number = 0;
  selectedIndex: number = 17;  // 默认选中项索引

  private validateInput(value: string, type: 'height' | 'weight'): string {
    const numValue = Number(value)
    if (type === 'height') {
      return Math.min(Math.max(numValue, 50), 250).toString() // 限制50-250cm
    }
    return Math.min(Math.max(numValue, 20), 300).toString() // 限制20-300kg
  }

  build() {
    NavDestination() {
      NavHeaderBar({
        title: '个人信息',
        onBack: () => {
          this.vm.customBack();
        },
      })

      GridRow(GridRowColSetting.DEFAULT_GRID_ROW_OPTIONS) {
        GridCol({
          span: GridRowColSetting.DEFAULT_CENTER_COL_SPAN,
          offset: GridRowColSetting.DEFAULT_CENTER_COL_OFFSET,
        }) {
          Scroll() {
            Column({ space: CommonConstants.SPACE_M }) {
              this.userIconBuilder()
              this.nickNameBuilder()
              List() {
                ListItem() {
                  this.genderBuilder()
                }

                ListItem() {
                  this.ageBuilder()
                }

                ListItem() {
                  this.heightBuilder()
                }

                ListItem() {
                  this.weightBuilder()
                }
              }
              .width(CommonConstants.FULL_PERCENT)
              .padding(CommonConstants.PADDING_XS)
              .borderRadius($r('app.float.large_radius'))
              .divider({
                strokeWidth: 0.5,
                color: $r('sys.color.comp_divider'),
                startMargin: CommonConstants.PADDING_M,
                endMargin: CommonConstants.PADDING_M,
              })
              .backgroundColor($r('sys.color.comp_background_primary'))

              List() {
                ListItem() {
                  this.purposeBuilder()
                }

                ListItem() {
                  this.bodyBuilder()
                }
              }
              .width(CommonConstants.FULL_PERCENT)
              .borderRadius($r('app.float.large_radius'))
              .padding(CommonConstants.PADDING_XS)
              .backgroundColor($r('sys.color.comp_background_primary'))
              .divider({
                strokeWidth: 0.5,
                color: $r('sys.color.comp_divider'),
                startMargin: CommonConstants.PADDING_M,
                endMargin: CommonConstants.PADDING_M,
              })
            }
            .padding({
              top: CommonConstants.PADDING_M,
              left: this.vm.breakPointModel.pagePadding,
              right: this.vm.breakPointModel.pagePadding,
              bottom: this.vm.windowModel.windowBottomPadding,
            })
          }
          .scrollBar(BarState.Off)
          .align(Alignment.Top)
          .layoutWeight(1)
          .edgeEffect(EdgeEffect.Spring)
        }
      }
      .layoutWeight(1)
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
    .onBackPressed(() => {
      this.vm.customBack();
      return true;
    })
  }

  @Styles
  pressedStyles(): void {
    .backgroundColor($r('sys.color.interactive_pressed'))
  }

  @Styles
  normalStyles() {
    .backgroundColor($r('sys.color.comp_background_primary'))
  }

  @Builder
  userIconBuilder() {
    Row() {
      Row() {
        Text('头像')
          .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
        Row({ space: CommonConstants.SPACE_XS }) {
          FunctionalButton({
            params: {
              openType: functionalButtonComponentManager.OpenType.CHOOSE_AVATAR,
              label: '',
              styleOption: {
                styleConfig: new functionalButtonComponentManager.ButtonConfig()
                  .type(ButtonType.Normal)
                  .backgroundImage(this.vm.userInfoModel.authorIcon ? this.vm.userInfoModel.authorIcon :
                  $r('app.media.ic_user_default'))
                  .backgroundImageSize(ImageSize.Cover)
                  .width(40)
                  .height(40)
                  .borderRadius(50)
                  .backgroundColor('#E5E5E5'),
              },
            },
            controller: new functionalButtonComponentManager.FunctionalButtonController().onChooseAvatar((err,
              data) => {
              if (err) {
                this.vm.handleAvatarError(err);
                return;
              }
              if (data) {
                this.vm.saveUserIcon(data.avatarUri!);
              }
            }),
          })
          Image($r('app.media.ic_right'))
            .width($r('app.float.arrow_right_w'))
            .draggable(false)
        }
        .accessibilityLevel('yes')
        .accessibilityText('切换头像')
      }
      .innerCard()
      .stateStyles({
        normal: this.normalStyles,
        pressed: this.pressedStyles,
      })
    }
    .outerCard()
  }

  @Builder
  nickNameBuilder() {
    Row() {
      Text('昵称')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(this.vm.userInfoModel.authorNickName)
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
          .constraintSize({ maxWidth: '80%' })
        Image($r('app.media.ic_right'))
          .draggable(false)
          .width($r('app.float.arrow_right_w'))
      }
    }
    .innerCard(48)
    .stateStyles({
      pressed: this.pressedStyles,
      normal: this.normalStyles,
    })
    .onClick(() => {
      this.vm.nickName = this.vm.userInfoModel.authorNickName;
      this.vm.showNickNameSheet = true;
    })
    .bindSheet($$this.vm.showNickNameSheet, this.modifyNameSheet(), {
      title: { title: '设置昵称' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      showClose: true,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  purposeBuilder() {
    Row() {
      Text('目标')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(AppStorage.get<string[]>('userPurpose')?.join(',') ? AppStorage.get<string[]>('userPurpose')?.join(',') : this.vm.userInfoModel.purpose.join(','))
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
          .constraintSize({ maxWidth: '80%' })
        Image($r('app.media.ic_right'))
          .width($r('app.float.arrow_right_w'))
          .draggable(false)
      }
    }
    .innerCard(48)
    .stateStyles({
      normal: this.normalStyles,
      pressed: this.pressedStyles,
    })
    .onClick(() => {
      purpose = [];
      this.vm.purpose = this.vm.userInfoModel.purpose;
      this.vm.showPurposeSheet = true;
    })
    .bindSheet($$this.vm.showPurposeSheet, this.modifyPurposeSheet(), {
      title: { title: '选择目标' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  bodyBuilder() {
    Row() {
      Text('想锻炼的部位')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(AppStorage.get<string[]>('userBody')?.join(',') ? AppStorage.get<string[]>('userBody')?.join(',') : this.vm.userInfoModel.body.join(','))
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
          .constraintSize({ maxWidth: '80%' })
        Image($r('app.media.ic_right'))
          .width($r('app.float.arrow_right_w'))
          .draggable(false)
      }
    }
    .innerCard(48)
    .stateStyles({
      normal: this.normalStyles,
      pressed: this.pressedStyles,
    })
    .onClick(() => {
      body = [];
      this.vm.body = this.vm.userInfoModel.body;
      this.vm.showBodySheet = true;
    })
    .bindSheet($$this.vm.showBodySheet, this.modifyBodySheet(), {
      title: { title: '选择锻炼部位' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  genderBuilder() {
    Row() {
      Text('性别')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(AppStorage.get<string>('userGender') ? AppStorage.get<string>('userGender') : this.vm.userInfoModel.authorGender)
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
          .constraintSize({ maxWidth: '80%' })
        Image($r('app.media.ic_right'))
          .width($r('app.float.arrow_right_w'))
          .draggable(false)
      }
    }
    .innerCard(48)
    .stateStyles({
      normal: this.normalStyles,
      pressed: this.pressedStyles,
    })
    .onClick(() => {
      this.vm.gender = this.vm.userInfoModel.authorGender;
      this.vm.showGenderSheet = true;
    })
    .bindSheet($$this.vm.showGenderSheet, this.modifyGenderSheet(), {
      title: { title: '选择性别' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  ageBuilder() {
    Row() {
      Text('年龄')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(AppStorage.get<string>('userAge') ? AppStorage.get<string>('userAge') : this.vm.userInfoModel.authorAge)
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
          .constraintSize({ maxWidth: '80%' })
        Image($r('app.media.ic_right'))
          .width($r('app.float.arrow_right_w'))
          .draggable(false)
      }
    }
    .innerCard(48)
    .stateStyles({
      normal: this.normalStyles,
      pressed: this.pressedStyles,
    })
    .onClick(() => {
      this.vm.age = this.vm.userInfoModel.authorAge;
      this.vm.showAgeSheet = true;
    })
    .bindSheet($$this.vm.showAgeSheet, this.modifyAgeSheet(), {
      title: { title: '选择年龄' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  heightBuilder() {
    Row() {
      Text('身高')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(AppStorage.get<string>('userHeight') ? AppStorage.get<string>('userHeight') : this.vm.userInfoModel.authorHeight + 'cm')
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
        Image($r('app.media.ic_right'))
          .draggable(false)
          .width($r('app.float.arrow_right_w'))
      }
    }
    .innerCard(48)
    .stateStyles({
      pressed: this.pressedStyles,
      normal: this.normalStyles,
    })
    .onClick(() => {
      this.vm.height = this.vm.userInfoModel.authorHeight;
      this.vm.showHeightSheet = true;
    })
    .bindSheet($$this.vm.showHeightSheet, this.modifyHeightSheet(), {
      title: { title: '请输入您的身高（cm）' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  weightBuilder() {
    Row() {
      Text('体重')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(AppStorage.get<string>('userWeight') ? AppStorage.get<string>('userWeight') : this.vm.userInfoModel.authorWeight + 'kg')
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
        Image($r('app.media.ic_right'))
          .width($r('app.float.arrow_right_w'))
          .draggable(false)
      }
    }
    .innerCard(48)
    .stateStyles({
      normal: this.normalStyles,
      pressed: this.pressedStyles,
    })
    .onClick(() => {
      this.vm.weight = this.vm.userInfoModel.authorWeight;
      this.vm.showWeightSheet = true;
    })
    .bindSheet($$this.vm.showWeightSheet, this.modifyWeightSheet(), {
      title: { title: '请输入您的体重（kg）' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  phoneBuilder() {
    Row() {
      Text('手机号')
        .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row({ space: CommonConstants.SPACE_XS }) {
        Text(this.vm.userInfoModel.authorPhone)
          .fontSize(14 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_secondary'))
        Image($r('app.media.ic_right'))
          .width($r('app.float.arrow_right_w'))
          .draggable(false)
      }
    }
    .innerCard(48)
    .stateStyles({
      normal: this.normalStyles,
      pressed: this.pressedStyles,
    })
    .onClick(() => {
      this.vm.contactPhone = this.vm.userInfoModel.authorPhone;
      this.vm.showPhoneSheet = true;
    })
    .bindSheet($$this.vm.showPhoneSheet, this.modifyPhoneSheet(), {
      title: { title: '设置手机号' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  personalDescBuilder() {
    Row() {
      Row() {
        Text('个人简介')
          .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
        Image($r('app.media.ic_right'))
          .width($r('app.float.arrow_right_w'))
          .draggable(false)
      }
      .innerCard()
      .stateStyles({
        normal: this.normalStyles,
        pressed: this.pressedStyles,
      })
    }
    .outerCard()
    .onClick(() => {
      this.vm.personalDesc = this.vm.userInfoModel.authorDesc;
      this.vm.showPersonDescSheet = true;
    })
    .bindSheet($$this.vm.showPersonDescSheet, this.modifyPersonalDescSheet(), {
      title: { title: '个人简介' },
      height: this.vm.defaultSheetH,
      detents: [this.vm.defaultSheetH, SheetSize.MEDIUM],
      showClose: true,
      keyboardAvoidMode: SheetKeyboardAvoidMode.RESIZE_ONLY,
      preferType: SheetType.CENTER,
      onTypeDidChange: (type: SheetType) => {
        this.vm.setSheetType(type);
      },
    })
  }

  @Builder
  modifyNameSheet() {
    Column() {
      Column() {
        TextInput({ text: $$this.vm.nickName })
          .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_primary'))
          .backgroundColor($r('sys.color.comp_background_tertiary'))
          .cancelButton({ style: CancelButtonStyle.INPUT, icon: { size: 16 } })
          .showCounter(true)
          .maxLength(20)
          .height(40)
          .margin({ top: 12 })
        Column() {
          Button('确定')
            .fontWeight(FontWeight.Medium)
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              this.vm.modifyNickName();
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .height(CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyPurposeSheet() {
    Column() {
      Column() {
        Column() {
          Text('大众常选')
            .height(45)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .padding({
              top: 16,
              bottom: 8,
            })

          Column() {
            Row({ space: 8 }) {
              CustomButton({ class: 'purpose', label: '增肌塑形' })

              CustomButton({ class: 'purpose', label: '减重瘦身' })

              CustomButton({ class: 'purpose', label: '强化心肺' })

              CustomButton({ class: 'purpose', label: '保持健康' })
            }
            .margin({ top: 4, bottom: 8 })

            Row({ space: 8 }) {
              CustomButton({ class: 'purpose', label: '力量训练' })

              CustomButton({ class: 'purpose', label: '马甲线' })

              CustomButton({ class: 'purpose', label: '增加柔韧' })

              CustomButton({ class: 'purpose', label: '随便练练' })
            }
            .margin({ bottom: 4 })
          }
        }
        .width(328)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              this.vm.modifyPurpose(purpose);
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyBodySheet() {
    Column() {
      Column() {
        Column() {
          Text('大众常选')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .height(45)
            .padding({
              top: 16,
              bottom: 8,
            })

          Column() {
            Row({ space: 8 }) {
              CustomButton({ class: 'body', label: '手臂' })

              CustomButton({ class: 'body', label: '大腿' })

              CustomButton({ class: 'body', label: '腹部' })

              CustomButton({ class: 'body', label: '臀部' })
            }
            .margin({ top: 4, bottom: 8 })

            Row({ space: 8 }) {
              CustomButton({ class: 'body', label: '胸肌' })

              CustomButton({ class: 'body', label: '背部' })

              CustomButton({ class: 'body', label: '肩部' })

              CustomButton({ class: 'body', label: '随便练练' })
            }
            .margin({ bottom: 4 })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .width(328)

        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              this.vm.modifyBody(body);
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyGenderSheet() {
    Column() {
      Column() {
        TextPicker({ range: this.genderPicker, selected: this.selectedGender })
          .canLoop(false)  // 禁用循环滚动
          .height(150)     // 设置选择器高度.textStyle({ color: Color.Black, font: { size: 20, weight: FontWeight.Normal } })
          .textStyle({ color: Color.Black, font: { size: 16, weight: FontWeight.Normal } })
          .selectedTextStyle({ color: $r('app.color.app_theme'), font: { size: 20, weight: FontWeight.Bolder } })
          .margin({ top: 12 })
          .onChange((value: string | string[], index: number | number[]) => {
            this.selectedGender = index as number
          })
        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              const selectedValue = this.genderPicker[this.selectedGender]
              this.vm.modifyGender(selectedValue);
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyAgeSheet() {
    Column() {
      Column() {
        TextPicker({ range: this.agePicker, selected: this.selectedIndex })
          .canLoop(false)  // 禁用循环滚动
          .height(200)     // 设置选择器高度.textStyle({ color: Color.Black, font: { size: 20, weight: FontWeight.Normal } })
          .textStyle({ color: Color.Black, font: { size: 16, weight: FontWeight.Normal } })
          .selectedTextStyle({ color: $r('app.color.app_theme'), font: { size: 20, weight: FontWeight.Bolder } })
          .margin({ top: 12 })
          .onChange((value: string | string[], index: number | number[]) => {
            this.selectedIndex = index as number
          })
        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              const selectedValue = this.agePicker[this.selectedIndex]
              this.vm.modifyAge(selectedValue);
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyHeightSheet() {
    Column() {
      Column() {
        TextInput({ text: $$this.vm.height })
          .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_primary'))
          .backgroundColor($r('sys.color.comp_background_tertiary'))
          .cancelButton({ style: CancelButtonStyle.INPUT, icon: { size: 16 } })
          .maxLength(20)
          .showCounter(true)
          .height(40)
          .margin({ top: 12 })
          .onChange((value: string) => { // 监听输入变化
            this.vm.height = value.replace(/[^0-9]/g, '') // 过滤非数字字符
          })
        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              this.vm.height = this.validateInput(this.vm.height, 'height')
              this.vm.modifyHeight();
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyWeightSheet() {
    Column() {
      Column() {
        TextInput({ text: $$this.vm.weight })
          .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_primary'))
          .backgroundColor($r('sys.color.comp_background_tertiary'))
          .cancelButton({ style: CancelButtonStyle.INPUT, icon: { size: 16 } })
          .maxLength(20)
          .showCounter(true)
          .height(40)
          .margin({ top: 12 })
          .onChange((value: string) => { // 监听输入变化
            this.vm.weight = value.replace(/[^0-9]/g, '') // 过滤非数字字符
          })
        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              this.vm.weight = this.validateInput(this.vm.weight, 'weight')
              this.vm.modifyWeight();
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyPhoneSheet() {
    Column() {
      Column() {
        TextInput({ text: $$this.vm.contactPhone })
          .type(InputType.PhoneNumber)
          .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_primary'))
          .backgroundColor($r('sys.color.comp_background_tertiary'))
          .cancelButton({ style: CancelButtonStyle.INPUT, icon: { size: 16 } })
          .maxLength(20)
          .showCounter(true)
          .height(40)
          .margin({ top: 12 })
        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              this.vm.modifyContactPhone();
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }

  @Builder
  modifyPersonalDescSheet() {
    Column() {
      Column() {
        TextArea({ text: $$this.vm.personalDesc, placeholder: '简单介绍一下自己吧~~' })
          .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
          .fontColor($r('sys.color.font_primary'))
          .backgroundColor($r('sys.color.comp_background_tertiary'))
          .placeholderColor($r('sys.color.font_secondary'))
          .placeholderFont({ size: 16 * this.vm.settingInfo.fontSizeRatio })
          .maxLength(70)
          .showCounter(true)
          .height(156)
          .margin({ top: 12 })
        Column() {
          Button('确定')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor($r('app.color.app_theme'))
            .width('100%')
            .onClick(() => {
              this.vm.modifyPersonalDesc();
            })
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: CommonConstants.PADDING_L,
      right: CommonConstants.PADDING_L,
      bottom: this.vm.getSheetPaddingBottom(),
    })
  }
}

@Extend(Row)
function innerCard(height: number | string = CommonConstants.FULL_PERCENT) {
  .width(CommonConstants.FULL_PERCENT)
  .height(height)
  .padding(CommonConstants.PADDING_S)
  .borderRadius($r('app.float.large_radius'))
  .justifyContent(FlexAlign.SpaceBetween)
}

@Extend(Row)
function outerCard(height: number = 56) {
  .width(CommonConstants.FULL_PERCENT)
  .height(height)
  .padding(CommonConstants.PADDING_XS)
  .borderRadius($r('app.float.large_radius'))
  .backgroundColor($r('sys.color.comp_background_primary'))
}