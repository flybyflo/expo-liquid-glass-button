import { useEvent } from 'expo';
import ExpoLiquidGlassButton, { ExpoLiquidGlassButtonView } from 'expo-liquid-glass-button';
import { Button, SafeAreaView, ScrollView, Text, View } from 'react-native';
import { Settings, Heart, Star } from 'lucide-react-native';

export default function App() {
  const onChangePayload = useEvent(ExpoLiquidGlassButton, 'onChange');

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.container}>
        <Text style={styles.header}>Module API Example</Text>
        <Group name="Constants">
          <Text>{ExpoLiquidGlassButton.PI}</Text>
        </Group>
        <Group name="Functions">
          <Text>{ExpoLiquidGlassButton.hello()}</Text>
        </Group>
        <Group name="Async functions">
          <Button
            title="Set value"
            onPress={async () => {
              await ExpoLiquidGlassButton.setValueAsync('Hello from JS!');
            }}
          />
        </Group>
        <Group name="Events">
          <Text>{onChangePayload?.value}</Text>
        </Group>
        <Group name="Views">
          <ExpoLiquidGlassButtonView
            title="Liquid Glass Button"
            onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Button pressed: ${buttonPressed}`)}
            style={styles.button}
          />
        </Group>
        <Group name="Round Button">
          <ExpoLiquidGlassButtonView
            title="x"
            isRound={true}
            textSize={32}
            onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Round button pressed: ${buttonPressed}`)}
            style={styles.roundButton}
          />
        </Group>
        <Group name="Large Text Button">
          <ExpoLiquidGlassButtonView
            title="Large Text"
            textSize={24}
            onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Large text button pressed: ${buttonPressed}`)}
            style={styles.button}
          />
        </Group>
        <Group name="Icon Button">
          <ExpoLiquidGlassButtonView
            title="Settings"
            icon="gear"
            onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Icon button pressed: ${buttonPressed}`)}
            style={styles.button}
          />
        </Group>
        <Group name="Heart Button">
          <ExpoLiquidGlassButtonView
            title="Like"
            icon="heart.fill"
            onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Heart button pressed: ${buttonPressed}`)}
            style={styles.button}
          />
        </Group>
        <Group name="Star Button">
          <ExpoLiquidGlassButtonView
            title="Favorite"
            icon="star.fill"
            onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Star button pressed: ${buttonPressed}`)}
            style={styles.button}
          />
        </Group>
        <Group name="Icon Only Buttons">
          <View style={{ flexDirection: 'row', justifyContent: 'space-around' }}>
            <ExpoLiquidGlassButtonView
              icon="heart.fill"
              onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Heart icon pressed: ${buttonPressed}`)}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon="star.fill"
              onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Star icon pressed: ${buttonPressed}`)}
              style={styles.iconButton}
            />
            <ExpoLiquidGlassButtonView
              icon="gear"
              onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Gear icon pressed: ${buttonPressed}`)}
              style={styles.iconButton}
            />
          </View>
        </Group>
        <Group name="Round Icon Buttons">
          <View style={{ flexDirection: 'row', justifyContent: 'space-around' }}>
            <ExpoLiquidGlassButtonView
              icon="message.fill"
              isRound={true}
              onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Chat icon pressed: ${buttonPressed}`)}
              style={styles.roundButton}
            />
            <ExpoLiquidGlassButtonView
              icon="plus.circle"
              isRound={true}
              onButtonPress={({ nativeEvent: { buttonPressed } }) => console.log(`Plus icon pressed: ${buttonPressed}`)}
              style={styles.roundButton}
            />
          </View>
        </Group>
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
  },
  groupHeader: {
    fontSize: 20,
    marginBottom: 20,
  },
  group: {
    margin: 20,
    backgroundColor: '#fff',
    borderRadius: 10,
    padding: 20,
  },
  container: {
    flex: 1,
    backgroundColor: '#eee',
  },
  view: {
    flex: 1,
    height: 100,
  },
  button: {
    height: 60,
    width: 250,
  },
  roundButton: {
    height: 80,
    width: 80,
    alignSelf: 'center' as const,
  },
  iconButton: {
    height: 60,
    width: 60,
  },
};
