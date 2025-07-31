import React from 'react';
import { TouchableOpacity, Text, StyleSheet, View, TextStyle, ViewStyle } from 'react-native';
import { ExpoLiquidGlassButtonViewProps } from './ExpoLiquidGlassButton.types';

export default function ExpoLiquidGlassButtonView({
  title = 'Button',
  onButtonPress,
  style,
  isRound = false,
  textSize = 16,
  icon,
  iconOnly = false,
  iconSize = 16,
  backgroundColor = 'rgba(255, 116, 135, 0.8)',
  textColor = '#FFFFFF',
  iconColor,
}: ExpoLiquidGlassButtonViewProps) {
  const handlePress = () => {
    onButtonPress?.({ nativeEvent: { buttonPressed: true } });
  };

  const buttonStyle: ViewStyle = {
    ...styles.button,
    borderRadius: isRound ? 50 : 12,
    backgroundColor: backgroundColor,
  };

  const textStyle: TextStyle = {
    ...styles.buttonText,
    fontSize: textSize,
    color: textColor,
  };

  const finalIconColor = iconColor || textColor;

  return (
    <View style={style}>
      <TouchableOpacity
        style={buttonStyle}
        onPress={handlePress}
        activeOpacity={0.8}
      >
        {iconOnly ? (
          <Text style={[textStyle, { fontSize: iconSize, color: finalIconColor }]}>
            {icon || '●'}
          </Text>
        ) : (
          <View style={styles.contentContainer}>
            {icon && (
              <Text style={[textStyle, { fontSize: iconSize, marginRight: 8, color: finalIconColor }]}>
                {icon}
              </Text>
            )}
            <Text style={textStyle}>{title}</Text>
          </View>
        )}
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  button: {
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 4,
    },
    shadowOpacity: 0.1,
    shadowRadius: 15,
  },
  buttonText: {
    fontWeight: '500',
    fontSize: 16,
  },
  contentContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
});