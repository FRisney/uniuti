﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using UniUti.Database;

#nullable disable

namespace UniUti.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20220515224507_MudancasModel")]
    partial class MudancasModel
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.4")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("CursoDisciplina", b =>
                {
                    b.Property<int>("CursosId")
                        .HasColumnType("int");

                    b.Property<int>("DisciplinasId")
                        .HasColumnType("int");

                    b.HasKey("CursosId", "DisciplinasId");

                    b.HasIndex("DisciplinasId");

                    b.ToTable("CursoDisciplina");
                });

            modelBuilder.Entity("UniUti.models.Curso", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int?>("InstituicaoId")
                        .HasColumnType("int");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.HasIndex("InstituicaoId");

                    b.ToTable("Cursos");
                });

            modelBuilder.Entity("UniUti.models.Disciplina", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Descricao")
                        .HasColumnType("longtext");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.ToTable("Disciplinas");
                });

            modelBuilder.Entity("UniUti.models.Endereco", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Cep")
                        .HasColumnType("longtext");

                    b.Property<string>("Cidade")
                        .HasColumnType("longtext");

                    b.Property<string>("Estado")
                        .HasColumnType("longtext");

                    b.Property<string>("Numero")
                        .HasColumnType("longtext");

                    b.Property<string>("Pais")
                        .HasColumnType("longtext");

                    b.Property<string>("Rua")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.ToTable("Enderecos");
                });

            modelBuilder.Entity("UniUti.models.Instituicao", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Celular")
                        .HasColumnType("longtext");

                    b.Property<string>("Email")
                        .HasColumnType("longtext");

                    b.Property<string>("EnderecoId")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.Property<string>("Telefone")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.HasIndex("EnderecoId");

                    b.ToTable("Instituicoes");
                });

            modelBuilder.Entity("UniUti.models.Monitoria", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<DateTime?>("DataCriacao")
                        .HasColumnType("datetime(6)");

                    b.Property<string>("Descricao")
                        .HasColumnType("longtext");

                    b.Property<int?>("DisciplinaId")
                        .HasColumnType("int");

                    b.Property<int?>("PrestadorId")
                        .HasColumnType("int");

                    b.Property<int?>("SolicitanteId")
                        .HasColumnType("int");

                    b.Property<int?>("StatusSolicitacaco")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("DisciplinaId");

                    b.HasIndex("PrestadorId");

                    b.HasIndex("SolicitanteId");

                    b.ToTable("Monitorias");
                });

            modelBuilder.Entity("UniUti.models.Usuario", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Celular")
                        .HasColumnType("longtext");

                    b.Property<int?>("CursoId")
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .HasColumnType("longtext");

                    b.Property<int?>("InstituicaoId")
                        .HasColumnType("int");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.Property<byte[]>("SenhaHash")
                        .HasColumnType("longblob");

                    b.Property<byte[]>("SenhaSalt")
                        .HasColumnType("longblob");

                    b.HasKey("Id");

                    b.HasIndex("CursoId");

                    b.HasIndex("InstituicaoId");

                    b.ToTable("Usuarios");
                });

            modelBuilder.Entity("CursoDisciplina", b =>
                {
                    b.HasOne("UniUti.models.Curso", null)
                        .WithMany()
                        .HasForeignKey("CursosId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("UniUti.models.Disciplina", null)
                        .WithMany()
                        .HasForeignKey("DisciplinasId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("UniUti.models.Curso", b =>
                {
                    b.HasOne("UniUti.models.Instituicao", null)
                        .WithMany("Cursos")
                        .HasForeignKey("InstituicaoId");
                });

            modelBuilder.Entity("UniUti.models.Instituicao", b =>
                {
                    b.HasOne("UniUti.models.Endereco", "Endereco")
                        .WithMany()
                        .HasForeignKey("EnderecoId");

                    b.Navigation("Endereco");
                });

            modelBuilder.Entity("UniUti.models.Monitoria", b =>
                {
                    b.HasOne("UniUti.models.Disciplina", "Disciplina")
                        .WithMany()
                        .HasForeignKey("DisciplinaId");

                    b.HasOne("UniUti.models.Usuario", "Prestador")
                        .WithMany()
                        .HasForeignKey("PrestadorId");

                    b.HasOne("UniUti.models.Usuario", "Solicitante")
                        .WithMany()
                        .HasForeignKey("SolicitanteId");

                    b.Navigation("Disciplina");

                    b.Navigation("Prestador");

                    b.Navigation("Solicitante");
                });

            modelBuilder.Entity("UniUti.models.Usuario", b =>
                {
                    b.HasOne("UniUti.models.Curso", "Curso")
                        .WithMany()
                        .HasForeignKey("CursoId");

                    b.HasOne("UniUti.models.Instituicao", "Instituicao")
                        .WithMany()
                        .HasForeignKey("InstituicaoId");

                    b.Navigation("Curso");

                    b.Navigation("Instituicao");
                });

            modelBuilder.Entity("UniUti.models.Instituicao", b =>
                {
                    b.Navigation("Cursos");
                });
#pragma warning restore 612, 618
        }
    }
}
