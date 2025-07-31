import { registerWebModule, NativeModule } from 'expo';

import { ExpoLiquidGlassButtonModuleEvents } from './ExpoLiquidGlassButton.types';

class ExpoLiquidGlassButtonModule extends NativeModule<ExpoLiquidGlassButtonModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoLiquidGlassButtonModule, 'ExpoLiquidGlassButtonModule');
