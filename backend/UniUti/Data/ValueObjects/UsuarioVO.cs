namespace UniUti.Data.ValueObjects
{
    public class UsuarioVO
    {
        public string? Nome { get; set; }
        public string? Email { get; set; }
        public byte[]? SenhaHash { get; set; }
        public byte[]? SenhaSalt { get; set; }
        public string? Celular { get; set; }
        public InstituicaoResponseVO? Instituicao { get; set; }
        public CursoResponseVO? Curso { get; set; }
    }
}