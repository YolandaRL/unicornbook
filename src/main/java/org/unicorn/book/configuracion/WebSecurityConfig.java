package org.unicorn.book.configuracion;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.thymeleaf.spring5.SpringTemplateEngine;
import org.thymeleaf.spring5.templateresolver.SpringResourceTemplateResolver;
import org.thymeleaf.spring5.view.ThymeleafViewResolver;
import org.unicorn.book.autenticacion.UserDetailsServiceImpl;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserDetailsServiceImpl UserDetailsServiceImpl;

    @Autowired
    private DataSource dataSource;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/", "/usuario/registro", "/registro", "/busquedas").permitAll()
                .antMatchers("/login").permitAll()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/client/**").hasRole("CLIENT")
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .failureUrl("/login?error")
                //.defaultSuccessUrl("/dashboard").successHandler(successHandler)
                .usernameParameter("username")
                .passwordParameter("password")
                .and()
                .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/login?logout").and().exceptionHandling().accessDeniedPage("/access-denied");

    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/error**","/webapp/resources/**", "/resources/**", "/static/**", "/css/**", "/js/**", "/img/**");
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth)
            throws Exception {
        auth.userDetailsService(UserDetailsServiceImpl)
             .and()
        .jdbcAuthentication()
                .passwordEncoder(this.passworEnconder())
                .dataSource(dataSource)
                .usersByUsernameQuery("SELECT USUARIO ,PASSWORD, ACTIVO FROM UNICORNBOOK.USUARIO WHERE USUARIO = ?")
                .authoritiesByUsernameQuery("SELECT U.USUARIO,R.NOMBRE_ROL FROM USUARIO_ROL UR " +
                        "INNER JOIN USUARIO U ON U.ID = UR.ID_USUARIO " +
                        "INNER JOIN ROL R ON R.ID_ROL = UR.ID WHERE U.USUARIO = ?");
    }


    @Bean
    public PasswordEncoder passworEnconder() {
        return new BCryptPasswordEncoder();
    }
}
