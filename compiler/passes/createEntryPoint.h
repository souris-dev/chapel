#ifndef _CREATE_ENTRY_POINT_H_
#define _CREATE_ENTRY_POINT_H_

#include "alist.h"
#include "pass.h"

class CreateEntryPoint : public Pass {
 public:
  virtual void run(Vec<ModuleSymbol*>* modules);
};

#endif
