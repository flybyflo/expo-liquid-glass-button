import { ExpoLiquidGlassButtonView } from 'expo-liquid-glass-button';
import { SafeAreaView, ScrollView, Text, View, Platform, Alert } from 'react-native';
import { useState } from 'react';

export default function App() {
  const [pressCount, setPressCount] = useState(0);

  const handleButtonPress = (buttonName: string) => {
    setPressCount(prev => prev + 1);
    if (Platform.OS === 'web') {
      alert(`${buttonName} pressed! Total presses: ${pressCount + 1}`);
    } else {
      Alert.alert('Button Pressed', `${buttonName} pressed! Total presses: ${pressCount + 1}`);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.container} contentContainerStyle={styles.scrollContent}>
        <Text style={styles.header}>Expo Liquid Glass Button</Text>
        <Text style={styles.subtitle}>Cross-platform liquid glass button component</Text>
        <Text style={styles.platformInfo}>Running on: {Platform.OS}</Text>
        <Group name="Basic Button">
          <ExpoLiquidGlassButtonView
            title="Tap Me!"
            onButtonPress={() => handleButtonPress('Basic Button')}
            style={styles.button}
          />
        </Group>

        <Group name="Button Sizes">
          <View style={styles.row}>
            <ExpoLiquidGlassButtonView
              title="Small"
              textSize={12}
              onButtonPress={() => handleButtonPress('Small Button')}
              style={styles.smallButton}
            />
            <ExpoLiquidGlassButtonView
              title="Medium"
              textSize={16}
              onButtonPress={() => handleButtonPress('Medium Button')}
              style={styles.mediumButton}
            />
            <ExpoLiquidGlassButtonView
              title="Large"
              textSize={20}
              onButtonPress={() => handleButtonPress('Large Button')}
              style={styles.largeButton}
            />
          </View>
        </Group>

        <Group name="Round Buttons">
          <View style={styles.row}>
            <ExpoLiquidGlassButtonView
              title="×"
              isRound={true}
              textSize={24}
              onButtonPress={() => handleButtonPress('Close Button')}
              style={styles.roundButton}
            />
            <ExpoLiquidGlassButtonView
              title="+"
              isRound={true}
              textSize={24}
              onButtonPress={() => handleButtonPress('Add Button')}
              style={styles.roundButton}
            />
            <ExpoLiquidGlassButtonView
              title="✓"
              isRound={true}
              textSize={20}
              onButtonPress={() => handleButtonPress('Check Button')}
              style={styles.roundButton}
            />
          </View>
        </Group>

        <Group name="Icon Buttons">
          <ExpoLiquidGlassButtonView
            title="Settings"
            icon={Platform.OS === 'ios' ? 'gear' : '⚙️'}
            onButtonPress={() => handleButtonPress('Settings Button')}
            style={styles.button}
          />
          <View style={styles.spacer} />
          <ExpoLiquidGlassButtonView
            title="Favorite"
            icon={Platform.OS === 'ios' ? 'heart.fill' : '❤️'}
            onButtonPress={() => handleButtonPress('Favorite Button')}
            style={styles.button}
          />
          <View style={styles.spacer} />
          <ExpoLiquidGlassButtonView
            title="Star"
            icon={Platform.OS === 'ios' ? 'star.fill' : '⭐'}
            onButtonPress={() => handleButtonPress('Star Button')}
            style={styles.button}
          />
        </Group>

        <Group name="Icon Only Buttons">
          <View style={styles.row}>
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'heart.fill' : '❤️'}
              iconOnly={true}
              onButtonPress={() => handleButtonPress('Heart Icon')}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'star.fill' : '⭐'}
              iconOnly={true}
              onButtonPress={() => handleButtonPress('Star Icon')}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'gear' : '⚙️'}
              iconOnly={true}
              onButtonPress={() => handleButtonPress('Settings Icon')}
              style={styles.iconButton}
            />
          </View>
        </Group>

        <Group name="Icon Sizes">
          <Text style={styles.description}>Different icon sizes</Text>
          <View style={styles.row}>
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'star.fill' : '⭐'}
              iconSize={12}
              iconOnly={true}
              onButtonPress={() => handleButtonPress('Small Star')}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'star.fill' : '⭐'}
              iconSize={20}
              iconOnly={true}
              onButtonPress={() => handleButtonPress('Medium Star')}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'star.fill' : '⭐'}
              iconSize={28}
              iconOnly={true}
              onButtonPress={() => handleButtonPress('Large Star')}
              style={styles.iconButton}
            />
          </View>
        </Group>

        <Group name="Round Icon Buttons">
          <View style={styles.row}>
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'message.fill' : '💬'}
              iconOnly={true}
              isRound={true}
              onButtonPress={() => handleButtonPress('Chat')}
              style={styles.roundButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'plus.circle' : '➕'}
              iconOnly={true}
              isRound={true}
              onButtonPress={() => handleButtonPress('Add Circle')}
              style={styles.roundButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'phone.fill' : '📞'}
              iconOnly={true}
              isRound={true}
              onButtonPress={() => handleButtonPress('Call')}
              style={styles.roundButton}
            />
          </View>
        </Group>

        <Group name="Custom Colors">
          <ExpoLiquidGlassButtonView
            title="Purple Button"
            backgroundColor="#8B5CF6"
            onButtonPress={() => handleButtonPress('Purple Button')}
            style={styles.button}
          />
          <View style={styles.spacer} />
          <ExpoLiquidGlassButtonView
            title="Green Success"
            backgroundColor="#10B981"
            onButtonPress={() => handleButtonPress('Green Button')}
            style={styles.button}
          />
          <View style={styles.spacer} />
          <ExpoLiquidGlassButtonView
            title="Orange Warning"
            backgroundColor="#F59E0B"
            textColor="#1F2937"
            onButtonPress={() => handleButtonPress('Orange Button')}
            style={styles.button}
          />
        </Group>

        <Group name="Colorful Icon Buttons">
          <View style={styles.row}>
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'heart.fill' : '❤️'}
              iconOnly={true}
              backgroundColor="#EF4444"
              onButtonPress={() => handleButtonPress('Red Heart')}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'star.fill' : '⭐'}
              iconOnly={true}
              backgroundColor="#F59E0B"
              onButtonPress={() => handleButtonPress('Yellow Star')}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon={Platform.OS === 'ios' ? 'checkmark' : '✅'}
              iconOnly={true}
              backgroundColor="#10B981"
              onButtonPress={() => handleButtonPress('Green Check')}
              style={styles.iconButton}
            />
          </View>
        </Group>

        <Group name="Gradient-like Effects">
          <ExpoLiquidGlassButtonView
            title="Ocean Blue"
            backgroundColor={Platform.OS === 'web' ? 'rgba(59, 130, 246, 0.8)' : '#3B82F6'}
            onButtonPress={() => handleButtonPress('Ocean Blue')}
            style={styles.button}
          />
          <View style={styles.spacer} />
          <ExpoLiquidGlassButtonView
            title="Sunset Pink"
            backgroundColor={Platform.OS === 'web' ? 'rgba(236, 72, 153, 0.8)' : '#EC4899'}
            onButtonPress={() => handleButtonPress('Sunset Pink')}
            style={styles.button}
          />
          <View style={styles.spacer} />
          <ExpoLiquidGlassButtonView
            title="Forest Green"
            backgroundColor={Platform.OS === 'web' ? 'rgba(34, 197, 94, 0.8)' : '#22C55E'}
            onButtonPress={() => handleButtonPress('Forest Green')}
            style={styles.button}
          />
        </Group>

        <View style={styles.footer}>
          <Text style={styles.footerText}>Total button presses: {pressCount}</Text>
          <Text style={styles.footerNote}>
            {Platform.OS === 'ios' && 'Using native iOS liquid glass effects'}
            {Platform.OS === 'android' && 'Using Material Design styling'}
            {Platform.OS === 'web' && 'Using CSS glass effects'}
          </Text>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

function Group(props: { name: string; children: React.ReactNode }) {
  return (
    <View style={styles.group}>
      <Text style={styles.groupHeader}>{props.name}</Text>
      {props.children}
    </View>
  );
}

const styles = {
  header: {
    fontSize: 30,
    margin: 20,
    textAlign: 'center' as const,
    fontWeight: 'bold' as const,
    color: '#1F2937',
  },
  subtitle: {
    fontSize: 16,
    marginHorizontal: 20,
    marginBottom: 10,
    textAlign: 'center' as const,
    color: '#6B7280',
  },
  platformInfo: {
    fontSize: 14,
    marginHorizontal: 20,
    marginBottom: 20,
    textAlign: 'center' as const,
    color: '#9CA3AF',
    fontStyle: 'italic' as const,
  },
  groupHeader: {
    fontSize: 20,
    marginBottom: 20,
    fontWeight: '600' as const,
    color: '#374151',
  },
  description: {
    fontSize: 14,
    marginBottom: 10,
    color: '#6B7280',
  },
  group: {
    margin: 20,
    backgroundColor: '#fff',
    borderRadius: 10,
    padding: 20,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5,
  },
  container: {
    flex: 1,
    backgroundColor: '#F3F4F6',
  },
  scrollContent: {
    paddingBottom: 20,
  },
  row: {
    flexDirection: 'row' as const,
    justifyContent: 'space-around',
    alignItems: 'center',
  },
  spacer: {
    height: 16,
  },
  button: {
    height: 60,
    width: 250,
    alignSelf: 'center' as const,
  },
  smallButton: {
    height: 40,
    width: 80,
  },
  mediumButton: {
    height: 50,
    width: 100,
  },
  largeButton: {
    height: 60,
    width: 120,
  },
  roundButton: {
    height: 80,
    width: 80,
  },
  iconButton: {
    height: 60,
    width: 60,
  },
  footer: {
    margin: 20,
    padding: 20,
    backgroundColor: '#fff',
    borderRadius: 10,
    alignItems: 'center' as const,
  },
  footerText: {
    fontSize: 18,
    fontWeight: '600' as const,
    color: '#374151',
    marginBottom: 8,
  },
  footerNote: {
    fontSize: 14,
    color: '#6B7280',
    textAlign: 'center' as const,
  },
};
