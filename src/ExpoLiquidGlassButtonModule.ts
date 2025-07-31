import { NativeModule, requireNativeModule } from 'expo';

import { ExpoLiquidGlassButtonModuleEvents } from './ExpoLiquidGlassButton.types';

declare class ExpoLiquidGlassButtonModule extends NativeModule<ExpoLiquidGlassButtonModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoLiquidGlassButtonModule>('ExpoLiquidGlassButton');
