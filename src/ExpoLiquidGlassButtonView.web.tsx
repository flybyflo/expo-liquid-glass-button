import * as React from 'react';

import { ExpoLiquidGlassButtonViewProps } from './ExpoLiquidGlassButton.types';

export default function ExpoLiquidGlassButtonView(props: ExpoLiquidGlassButtonViewProps) {
  return (
    <button
      style={{
        padding: 1,
        backgroundColor: '#007AFF',
        color: 'white',
        border: 'none',
        borderRadius: props.isRound ? '50%' : 8,
        fontSize: props.textSize || 16,
        cursor: 'pointer',
        width: props.isRound ? '60px' : 'auto',
        height: props.isRound ? '60px' : 'auto',
        display: props.isRound ? 'flex' : 'block',
        alignItems: props.isRound ? 'center' : 'stretch',
        justifyContent: props.isRound ? 'center' : 'flex-start',
      }}
      onClick={() => props.onButtonPress?.({ nativeEvent: { buttonPressed: true } })}
    >
      {props.title || 'Button'}
    </button>
  );
}
