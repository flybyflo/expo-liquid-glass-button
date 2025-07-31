import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoLiquidGlassButtonViewProps } from './ExpoLiquidGlassButton.types';

const NativeView: React.ComponentType<ExpoLiquidGlassButtonViewProps> =
  requireNativeView('ExpoLiquidGlassButton');

export default function ExpoLiquidGlassButtonView(props: ExpoLiquidGlassButtonViewProps) {
  return <NativeView {...props} />;
}
