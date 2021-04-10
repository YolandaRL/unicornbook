package org.unicorn.book.app.usuario.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.unicorn.book.app.usuario.dto.TablaMaestraView;
import org.unicorn.book.app.usuario.model.TipoOperacion;

import java.util.List;

@Repository
public interface TipoOperacionRepository extends JpaRepository<TipoOperacion, Long> {

    List<TablaMaestraView> findAllByOrderByIdAsc();
}
