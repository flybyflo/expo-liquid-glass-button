import * as React from 'react';

import { ExpoLiquidGlassButtonViewProps } from './ExpoLiquidGlassButton.types';

export default function ExpoLiquidGlassButtonView(props: ExpoLiquidGlassButtonViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
