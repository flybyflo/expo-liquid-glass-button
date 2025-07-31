import type { StyleProp, ViewStyle } from 'react-native';

export type OnPressEventPayload = {
  buttonPressed: boolean;
};

export type ExpoLiquidGlassButtonModuleEvents = {
  onChange: (params: ChangeEventPayload) => void;
};

export type ChangeEventPayload = {
  value: string;
};

export type ExpoLiquidGlassButtonViewProps = {
  title?: string;
  onButtonPress?: (event: { nativeEvent: OnPressEventPayload }) => void;
  style?: StyleProp<ViewStyle>;
  isRound?: boolean;
  textSize?: number;
  icon?: string;
  iconOnly?: boolean;
};
