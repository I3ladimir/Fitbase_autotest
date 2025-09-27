import com.microsoft.playwright.*;

import java.util.concurrent.TimeoutException;

class AuthTest {
    public static void main(String[] args) {
        try (Playwright playwright = Playwright.create()) {
            Browser browser = playwright.chromium().launch(new BrowserType.LaunchOptions().setHeadless(false));
            BrowserContext context = browser.newContext();
            Page page = context.newPage();

            // Открываем страницу
            page.navigate("https://demo.fitbase.io");

            // Ввод логина
            page.fill("input[name='LoginForm[username]']", "логин");
            // Ввод пароля
            page.fill("input[name='LoginForm[password]']", "пароль");

            // Нажатие кнопки Вход
            page.click("button[type='submit']");

            // Ожидаем переход на страницу после входа
            String expectedUrlPattern = "https://demo.fitbase.io/*";
            
            page.waitForURL(expectedUrlPattern, new Page.WaitForURLOptions().setTimeout(5000));
            System.out.println("Authorization is successful by URL change");

            browser.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
