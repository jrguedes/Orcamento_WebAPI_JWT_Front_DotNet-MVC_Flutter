using AutoMapper;
using Orcamento.API.Dtos.RequestDto;
using Orcamento.API.Dtos.ResponseDto;
using Models = Orcamento.API.Models;

namespace Orcamento.API.Dtos.Mappings;

public class GeneralDtoMappingProfile : Profile
{
    public GeneralDtoMappingProfile()
    {
        CreateMap<Models.Orcamento, CreateOrcamentoRequest>().ReverseMap();
        CreateMap<Models.Orcamento, UpdateOrcamentoRequest>().ReverseMap();

        CreateMap<Models.ItemOrcamento, CreateItemOrcamentoRequest>().ReverseMap();
        CreateMap<Models.ItemOrcamento, UpdateItemOrcamentoRequest>().ReverseMap();
        
        CreateMap<Models.Orcamento, OrcamentoResponse>().ReverseMap();
        CreateMap<Models.ItemOrcamento, ItemOrcamentoResponse>().ReverseMap();
    }
}
