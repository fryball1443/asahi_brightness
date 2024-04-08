import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class BrightnessControl extends JFrame {
    private static final String backlightFile = "/sys/class/backlight/apple-panel-bl/brightness";
    private static final String maxBacklightFile = "/sys/class/backlight/apple-panel-bl/max_brightness";
    private static final String keyBacklightFile = "/sys/devices/platform/led-controller/leds/kbd_backlight/brightness";
    private static final String maxKeyBacklightFile = "/sys/devices/platform/led-controller/leds/kbd_backlight/max_brightness";

    private JSlider screenSlider;
    private JSlider keyboardSlider;

    public BrightnessControl() {
        setTitle("Brightness Control");
        setSize(500, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new FlowLayout());

        screenSlider = new JSlider(JSlider.HORIZONTAL, 0, getMaxBrightness(maxBacklightFile), getCurrentBrightness(backlightFile));
        screenSlider.setMajorTickSpacing(10);
        screenSlider.setMinorTickSpacing(1);
        screenSlider.setPaintTicks(true);
        screenSlider.setPaintLabels(true);
        add(screenSlider);

        keyboardSlider = new JSlider(JSlider.HORIZONTAL, 0, getMaxBrightness(maxKeyBacklightFile), getCurrentBrightness(keyBacklightFile));
        keyboardSlider.setMajorTickSpacing(10);
        keyboardSlider.setMinorTickSpacing(1);
        keyboardSlider.setPaintTicks(true);
        keyboardSlider.setPaintLabels(true);
        add(keyboardSlider);

        JButton applyButton = new JButton("Apply");
        applyButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                applyChanges();
            }
        });
        add(applyButton);

        JButton revertButton = new JButton("Revert");
        revertButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                revertChanges();
            }
        });
        add(revertButton);

        JButton exitButton = new JButton("Exit");
        exitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                exitProgram();
            }
        });
        add(exitButton);
    }

    private int getMaxBrightness(String file) {
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            return Integer.parseInt(reader.readLine().trim());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int getCurrentBrightness(String file) {
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            return Integer.parseInt(reader.readLine().trim());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private void setBrightness(String file, int value) {
        try (FileWriter writer = new FileWriter(file)) {
            writer.write(Integer.toString(value));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void applyChanges() {
        setBrightness(backlightFile, screenSlider.getValue());
        setBrightness(keyBacklightFile, keyboardSlider.getValue());
    }

    private void revertChanges() {
        screenSlider.setValue(getCurrentBrightness(backlightFile));
        keyboardSlider.setValue(getCurrentBrightness(keyBacklightFile));
    }

    private void exitProgram() {
        revertChanges();
        System.exit(0);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new BrightnessControl().setVisible(true);
            }
        });
    }
}
