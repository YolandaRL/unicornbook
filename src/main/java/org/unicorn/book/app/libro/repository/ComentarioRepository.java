package org.unicorn.book.app.libro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.unicorn.book.app.libro.model.Comentario;
import org.unicorn.book.app.libro.model.ComentarioPk;
import org.unicorn.book.app.usuario.dto.ComentarioView;

import java.util.List;

@Repository
public interface ComentarioRepository extends JpaRepository<Comentario, ComentarioPk> {

    List<ComentarioView> findAllByUsuarioId(Long id);

    List<Comentario> findAllByLibroId(Long id);

    Comentario getFirstByLibroIdAndUsuarioId(Long idLibro, Long idUsuario);
}
